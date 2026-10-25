return {
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "c", "cpp", "cmake" },
    cmd = {
      "CMakeGenerate",
      "CMakeBuild",
      "CMakeRun",
      "CMakeDebug",
      "CMakeClean",
      "CMakeRunTest",
      "CMakeSelectConfigurePreset",
      "CMakeSelectBuildPreset",
      "CMakeSelectBuildTarget",
      "CMakeSelectLaunchTarget",
    },
    keys = {
      { "<leader>cg", "<cmd>CMakeGenerate<cr>",              desc = "CMake: Configure" },
      { "<leader>cb", "<cmd>CMakeBuild<cr>",                 desc = "CMake: Build" },
      { "<leader>cr", "<cmd>CMakeRun<cr>",                   desc = "CMake: Run" },
      { "<leader>cd", "<cmd>CMakeDebug<cr>",                 desc = "CMake: Debug" },
      { "<leader>cc", "<cmd>CMakeClean<cr>",                 desc = "CMake: Clean" },
      { "<leader>cT", "<cmd>CMakeRunTest<cr>",               desc = "CMake: Run tests" },
      { "<leader>cp", "<cmd>CMakeSelectConfigurePreset<cr>", desc = "CMake: Select configure preset" },
      { "<leader>cP", "<cmd>CMakeSelectBuildPreset<cr>",     desc = "CMake: Select build preset" },
      { "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>",     desc = "CMake: Select build target" },
      { "<leader>cl", "<cmd>CMakeSelectLaunchTarget<cr>",    desc = "CMake: Select launch target" },
    },
    opts = {
      -- After configuring, compile_commands.json is symlinked from the
      -- preset's build directory into the project root, where clangd finds it
      cmake_compile_commands_options = {
        action = "soft_link",
      },
      -- Debug the launch target with the gdb adapter from debug.lua. The
      -- program, args and cwd are filled in from the selected target.
      cmake_dap_configuration = {
        name = "cpp",
        type = "gdb",
        request = "launch",
        stopAtBeginningOfMainSubprogram = false,
      },
    },
    config = function(_, opts)
      local cmake = require("cmake-tools")
      cmake.setup(opts)

      -- clangd only looks for compile_commands.json when it starts, so when
      -- the first configure creates the link, restart it to pick it up
      local configure_compile_commands = cmake.configure_compile_commands
      cmake.configure_compile_commands = function(...)
        local link = vim.fs.joinpath(vim.uv.cwd(), "compile_commands.json")
        local existed = vim.uv.fs_stat(link) ~= nil
        configure_compile_commands(...)
        if not existed and vim.uv.fs_stat(link) and #vim.lsp.get_clients({ name = "clangd" }) > 0 then
          vim.cmd("lsp restart clangd")
        end
      end
    end,
  },
}
