return {
  "sudo-tee/opencode.nvim",
  config = function()
    require("opencode").setup({
      -- Usar telescope como picker (ya lo tienes instalado)
      preferred_picker = "telescope",
      -- Usar nvim-cmp para autocompletado
      preferred_completion = "nvim-cmp",
      -- Configuración de la UI
      ui = {
        -- Panel a la derecha como solicitaste
        position = "right",
        -- Ancho del panel (40% del editor)
        window_width = 0.40,
        -- Usar nerdfonts para iconos
        icons = {
          preset = "nerdfonts",
        },
        -- Configuración de highlights para fondo transparente
        window_highlight = "Normal:OpencodeBackground,FloatBorder:OpencodeBorder",
        -- Mostrar información útil
        display_model = true,
        display_context_size = true,
        display_cost = true,
        -- Persistir estado para restauración rápida
        persist_state = true,
        -- Input en la parte inferior
        input_position = "bottom",
      },
      -- Keymaps personalizados
      keymap = {
        editor = {
          ["<leader>og"] = { "toggle", desc = "Toggle Opencode" },
          ["<leader>oi"] = { "open_input", desc = "Open input window" },
          ["<leader>oI"] = { "open_input_new_session", desc = "Open input with new session" },
          ["<leader>oo"] = { "open_output", desc = "Open output window" },
          ["<leader>ot"] = { "toggle_focus", desc = "Toggle focus" },
          ["<leader>os"] = { "select_session", desc = "Select session" },
          ["<leader>oR"] = { "rename_session", desc = "Rename session" },
          ["<leader>oT"] = { "timeline", desc = "Open timeline" },
          ["<leader>op"] = { "configure_provider", desc = "Configure provider/model" },
          ["<leader>od"] = { "diff_open", desc = "Open diff view" },
          ["<leader>o]"] = { "diff_next", desc = "Next diff" },
          ["<leader>o["] = { "diff_prev", desc = "Previous diff" },
          ["<leader>oc"] = { "diff_close", desc = "Close diff" },
          ["<leader>ox"] = { "swap_position", desc = "Swap panel position" },
          ["<leader>o/"] = { "quick_chat", mode = { "n", "x" }, desc = "Quick chat" },
          ["<leader>oy"] = { "add_visual_selection", mode = { "v" }, desc = "Add selection to context" },
          ["<leader>oa"] = { "select_agent", desc = "Select agent/mode" },
        },
        input_window = {
          ["<S-CR>"] = { "submit_input_prompt", mode = { "n", "i" }, desc = "Submit prompt" },
          ["<esc>"] = false,
          ["<C-c>"] = false,
          ["~"] = { "mention_file", mode = "i", desc = "Mention file" },
          ["@"] = { "mention", mode = "i", desc = "Mention" },
          ["/"] = { "slash_commands", mode = "i", desc = "Slash commands" },
          ["#"] = { "context_items", mode = "i", desc = "Context items" },
          ["<TAB>"] = { "toggle_pane", mode = { "n", "i" }, desc = "Toggle panes" },
          ["<UP>"] = { "prev_prompt_history", mode = { "n", "i" }, desc = "Previous prompt" },
          ["<DOWN>"] = { "next_prompt_history", mode = { "n", "i" }, desc = "Next prompt" },
        },
        output_window = {
          ["<esc>"] = false,
          ["<C-c>"] = false,
          ["]]"] = { "next_message", desc = "Next message" },
          ["[["] = { "prev_message", desc = "Previous message" },
          ["<TAB>"] = { "toggle_pane", mode = { "n", "i" }, desc = "Toggle panes" },
          ["i"] = { "focus_input", mode = "n", desc = "Focus input" },
        },
      },
      -- Contexto automático
      context = {
        enabled = true,
        current_file = {
          enabled = true,
          show_full_path = true,
        },
        selection = {
          enabled = true,
        },
        diagnostics = {
          info = false,
          warn = true,
          error = true,
        },
      },
    })

    -- Desactivar el autocommand WinClosed del plugin para que solo :q cierre
    vim.defer_fn(function()
      local ok, opencode_ui = pcall(require, 'opencode.ui.ui')
      if ok and opencode_ui then
        -- Crear grupo personalizado que limpia el comportamiento de cierre automático
        local group = vim.api.nvim_create_augroup('OpencodeCustom', { clear = true })

        vim.api.nvim_create_autocmd('WinClosed', {
          group = group,
          pattern = '*',
          callback = function(args)
            local state = require('opencode.state')
            if not state.windows then return end

            local closed_win = tonumber(args.match)
            local wins = { state.windows.input_win, state.windows.output_win, state.windows.footer_win }

            -- Solo procesar si es una ventana de opencode
            if not vim.tbl_contains(wins, closed_win) then
              return
            end

            -- Verificar si el cierre fue manual mediante :q
            -- Esto se detecta revisando si quedan ventanas de opencode abiertas
            local remaining_wins = 0
            for _, win in ipairs(wins) do
              if win and win ~= closed_win and vim.api.nvim_win_is_valid(win) then
                remaining_wins = remaining_wins + 1
              end
            end

            -- Si quedan ventanas abiertas, no hacer teardown (permitir cierre individual)
            -- Si es la última ventana, permitir el teardown normal
            if remaining_wins > 0 then
              -- No hacer nada - dejar que la ventana se cierre individualmente
              return true
            end
          end,
        })
      end
    end, 100)

    -- Configurar highlights para fondo transparente (integración con Gruvbox)
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        -- Fondo transparente para opencode (igual que NeoTree)
        vim.api.nvim_set_hl(0, "OpencodeBackground", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "OpencodeBorder", { bg = "NONE", fg = "#928374" })              -- Color gris de Gruvbox
        vim.api.nvim_set_hl(0, "OpencodeHeader", { bg = "NONE", fg = "#fabd2f", bold = true }) -- Amarillo Gruvbox
        vim.api.nvim_set_hl(0, "OpencodeInput", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "OpencodeOutput", { bg = "NONE" })
      end,
    })

    -- Aplicar highlights inmediatamente
    vim.api.nvim_set_hl(0, "OpencodeBackground", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "OpencodeBorder", { bg = "NONE", fg = "#928374" })
    vim.api.nvim_set_hl(0, "OpencodeHeader", { bg = "NONE", fg = "#fabd2f", bold = true })
    vim.api.nvim_set_hl(0, "OpencodeInput", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "OpencodeOutput", { bg = "NONE" })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = { "markdown", "opencode_output" },
    },
  },
  -- Cargar bajo demanda con comandos específicos
  cmd = {
    "Opencode",
    "OpencodeOpenInput",
    "OpencodeOpenOutput",
    "OpencodeClose",
    "OpencodeToggle",
  },
  keys = {
    { "<leader>og", desc = "Toggle Opencode" },
    { "<leader>oi", desc = "Open Opencode input" },
    { "<leader>oa", desc = "Select agent/mode" },
    { "<leader>o/", desc = "Opencode quick chat", mode = { "n", "v" } },
  },
}
