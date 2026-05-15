local cmp = require('cmp')

local source = {}

source.new = function()
  return setmetatable({
    signature_help = nil,
  }, { __index = source })
end

source.is_available = function(self)
  return self:_get_client() ~= nil
end

source.get_keyword_pattern = function(self)
  return ([=[\%%(\V%s\m\)\s*\zs]=]):format(table.concat(self:get_trigger_characters(), [[\m\|\V]]))
end

source.get_trigger_characters = function(self)
  local trigger_characters = {}
  for _, c in ipairs(self:_get(self:_get_client().server_capabilities, { 'signatureHelpProvider', 'triggerCharacters' })
    or {}) do
    table.insert(trigger_characters, c)
  end
  for _, c in ipairs(self:_get(self:_get_client().server_capabilities, { 'signatureHelpProvider', 'retriggerCharacters' })
    or {}) do
    table.insert(trigger_characters, c)
  end
  table.insert(trigger_characters, ' ')
  return trigger_characters
end

source.complete = function(self, params, callback)
  local client = self:_get_client()
  local trigger_characters = {}
  for _, c in ipairs(self:_get(client.server_capabilities, { 'signatureHelpProvider', 'triggerCharacters' }) or {}) do
    table.insert(trigger_characters, c)
  end
  for _, c in ipairs(self:_get(client.server_capabilities, { 'signatureHelpProvider', 'retriggerCharacters' }) or {}) do
    table.insert(trigger_characters, c)
  end

  local trigger_character = nil
  for _, c in ipairs(trigger_characters) do
    local s, e = string.find(params.context.cursor_before_line, '(' .. vim.pesc(c) .. ')%s*$')
    if s and e then
      trigger_character = string.sub(params.context.cursor_before_line, s, s)
      break
    end
  end
  if not trigger_character then
    return callback({ isIncomplete = true })
  end

  local request = vim.lsp.util.make_position_params(0, self:_get_client().offset_encoding)
  request.context = {
    triggerKind = 2,
    triggerCharacter = trigger_character,
    isRetrigger = not not self.signature_help,
    activeSignatureHelp = self.signature_help,
  }

  -- Local override for the upstream plugin until it switches off the deprecated dot-call form.
  client:request('textDocument/signatureHelp', request, function(_, signature_help)
    self.signature_help = signature_help

    if not signature_help then
      return callback({ isIncomplete = true })
    end

    self.signature_help.activeSignature = self.signature_help.activeSignature or 0
    callback({
      isIncomplete = true,
      items = self:_items(self.signature_help),
    })
  end)
end

source._items = function(self, signature_help)
  if not signature_help or not signature_help.signatures then
    return {}
  end

  local items = {}
  for _, signature in ipairs(signature_help.signatures) do
    local item = self:_item(signature, signature_help.activeParameter)
    if item then
      table.insert(items, item)
    end
  end

  return items
end

source._item = function(self, signature, parameter_index)
  local parameters = signature.parameters
  if not parameters then
    return nil
  end

  parameter_index = (signature.activeParameter or parameter_index or 0) + 1

  if #parameters < parameter_index or parameter_index < 1 then
    parameter_index = 1
  end

  local arguments = {}
  for i, parameter in ipairs(parameters) do
    if i == parameter_index then
      table.insert(arguments, self:_parameter_label(signature, parameter))
    end
  end

  if #arguments == 0 then
    return nil
  end

  local label = table.concat(arguments, ', ')
  return {
    label = label,
    filterText = ' ',
    insertText = self:_matchstr(label, [[\k\+]]),
    word = '',
    preselect = true,
    documentation = self:_docs(signature, parameter_index),
  }
end

source._docs = function(self, signature, parameter_index)
  local documentation = {}

  if signature.label then
    table.insert(documentation, self:_signature_label(signature, parameter_index))
  end

  local parameter = signature.parameters[parameter_index]
  if parameter then
    if parameter.documentation then
      table.insert(documentation, '---')
      table.insert(documentation, self:_get_docs(parameter.documentation))
    end
  end

  if signature.documentation then
    table.insert(documentation, '---')
    table.insert(documentation, self:_get_docs(signature.documentation))
  end

  return {
    kind = cmp.lsp.MarkupKind.Markdown,
    value = table.concat(documentation, '\n'),
  }
end

source._signature_label = function(self, signature, parameter_index)
  local label = signature.label
  local parameters = signature.parameters
  local parameter = parameters and parameters[parameter_index]

  if not parameter then
    return '```vim\n' .. label .. '\n```'
  end

  local parts = self:_get_parameter_parts(label, parameter)
  if not parts then
    return '```vim\n' .. label .. '\n```'
  end

  return ('```vim\n%s%s%s\n```'):format(parts[1], self:_parameter_label(signature, parameter), parts[2])
end

source._parameter_label = function(self, signature, parameter)
  local parts = self:_get_parameter_parts(signature.label, parameter)
  if not parts then
    return ''
  end

  return ('`%s`'):format(parts[2])
end

source._get_parameter_parts = function(self, label, parameter)
  local parameter_label = parameter.label
  if type(parameter_label) == 'string' then
    local s, e = string.find(label, parameter_label, 1, true)
    if not s or not e then
      return nil
    end
    return {
      string.sub(label, 1, s - 1),
      string.sub(label, s, e),
      string.sub(label, e + 1),
    }
  end
  if type(parameter_label) == 'table' then
    return {
      string.sub(label, 1, parameter_label[1]),
      string.sub(label, parameter_label[1] + 1, parameter_label[2]),
      string.sub(label, parameter_label[2] + 1),
    }
  end
  return nil
end

source._get_docs = function(self, documentation)
  return type(documentation) == 'string' and documentation or documentation.value
end

source._get_client = function(self)
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  for _, client in ipairs(clients) do
    if self:_get(client.server_capabilities, { 'signatureHelpProvider' }) then
      return client
    end
  end
end

source._get = function(self, tbl, keys)
  local value = tbl
  for _, key in ipairs(keys) do
    if type(value) ~= 'table' then
      return nil
    end
    value = value[key]
  end
  return value
end

source._matchstr = function(self, str, pattern)
  local s, e = string.find(str, pattern)
  if s and e then
    return string.sub(str, s, e)
  end
  return ''
end

return source
