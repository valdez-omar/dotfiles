local M = {}

M.setup = function()
	require("codecompanion").setup({
		adapters = {
			-- Groq adapter (Ensure GROQ_API_KEY is set in your environment)
			groq = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					name = "groq",
					formatted_name = "Groq",
					url = "https://api.groq.com/openai/v1/chat/completions",
					env = {
						api_key = "GROQ_API_KEY",
					},
					schema = {
						model = {
							default = "gemma2-9b-it",
							choices = {
								"gemma2-9b-it",
								"llama3-70b-8192",
								"mixtral-8x7b-32768",
							},
						},
					},
				})
			end,

			-- Samba adapter
			samba = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					name = "samba",
					formatted_name = "SambaNova",
					url = "https://api.sambanova.ai/v1/chat/completions",
					env = {
						api_key = "SAMBA_API_KEY",
					},
					schema = {
						model = {
							default = "Meta-Llama-3.3-70B-Instruct",
							choices = {
								"Meta-Llama-3.3-70B-Instruct",
							},
						},
					},
				})
			end,

			-- Together adapter
			together = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					name = "together",
					formatted_name = "Together AI",
					url = "https://api.together.xyz/v1/chat/completions",
					env = {
						api_key = "TOGETHER_API_KEY",
					},
					schema = {
						model = {
							default = "meta-llama/Llama-3.3-70B-Instruct-Turbo-Free",
							choices = {
								"meta-llama/Llama-3.3-70B-Instruct-Turbo-Free",
								"deepseek-ai/DeepSeek-R1-Distill-Llama-70B-free",
							},
						},
					},
				})
			end,

			-- Ollama adapter (local)
			ollama = function()
				return require("codecompanion.adapters").extend("ollama", {
					schema = {
						model = {
							default = "llama3:latest",
							choices = {
								"llama3:latest",
								"mistral:latest",
								"deepseek-coder:latest",
								"gemma:latest",
							},
						},
					},
				})
			end,

			-- OpenAI adapter
			openai = function()
				return require("codecompanion.adapters").extend("openai", {
					env = {
						api_key = "OPENAI_API_KEY",
					},
					schema = {
						model = {
							default = "gpt-4.1-nano",
							choices = {
								"gpt-4.1-mini",
								"gpt-4o-mini",
							},
						},
					},
				})
			end,

			-- Gemini adapter
			gemini = function()
				return require("codecompanion.adapters").extend("gemini", {
					env = {
						api_key = "GEMINI_API_KEY",
					},
					schema = {
						model = {
							default = "gemini-2.5-pro-exp-03-25",
							choices = {
								"gemini-2.5-pro-exp-03-25",
								"gemini-2.5-flash-preview-04-17",
								"gemini-2.0-flash-lite",
							},
						},
					},
				})
			end,
		},

		-- Set Groq as the default adapter
		strategies = {
			chat = { adapter = "gemini" },
			inline = { adapter = "gemini" },
			agent = { adapter = "gemini" },
		},

		-- Display settings
		display = {
			chat = {
				show_settings = true,
				show_token_count = true,
				window = {
					layout = "vertical",
				},
			},
			-- Optional: Configure action palette UI provider if desired
			-- action_palette = {
			--   provider = "telescope", -- or "mini_pick" or "vim.ui.select" (default)
			-- }
		},

		-- Additional options
		opts = {
			log_level = "DEBUG", -- Keep for troubleshooting if needed, change to INFO or WARN later
		},
	})
end

-- Call the setup function when this file is required
M.setup()

return M
