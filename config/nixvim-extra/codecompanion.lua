require('codecompanion').setup({
  adapters = {
    siliconflow_r1 = function()
      return require('codecompanion.adapters').extend('deepseek', {
        name = 'siliconflow_r1',
        url = 'https://api.siliconflow.cn/v1/chat/completions',
        env = {
          api_key = function()
            return os.getenv('SILICONFLOW_API_KEY')
          end,
        },
        schema = {
          model = {
            default = 'deepseek-ai/DeepSeek-R1',
            choices = {
              ['deepseek-ai/DeepSeek-R1'] = { opts = { can_reason = true } },
              'deepseek-ai/DeepSeek-V3',
            },
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = 'siliconflow_r1',
      opts = {
        schema = {
          model = 'deepseek-ai/DeepSeek-V3',
        },
      },
    },
    inline = {
      adapter = 'siliconflow_r1',
      opts = {
        schema = {
          model = 'deepseek-ai/DeepSeek-V3',
        },
      },
    },
    action = {
      adapter = 'siliconflow_r1',
      opts = {
        schema = {
          model = 'deepseek-ai/DeepSeek-V3',
        },
      },
    },
  },
})
