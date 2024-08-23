local status, ollama = pcall(require, 'ollama')
if (not status) then return end

local opts = {
  model = "codellama",
  url = "http://127.0.0.1:11434",
  serve = {
    on_start = false,
    command = "codellama:34b",
    args = { "serve" },
    stop_command = "pkill",
    stop_args = { "-SIGTERM", "ollama" },
  },
  -- View the actual default prompts in ./lua/ollama/prompts.lua
  prompts = {
    Sample_Prompt = {
      prompt = "This is a sample prompt that receives $input and $sel(ection), among others.",
      input_label = "> ",
      model = "codellama:34b",
      action = "display",
    }
  }
}

ollama.setup(opts)
