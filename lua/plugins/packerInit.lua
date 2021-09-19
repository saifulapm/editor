local cmd = vim.cmd

cmd "packadd packer.nvim"

local present, packer = pcall(require, "packer")

if not present then
   local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

   print "Cloning packer.."
   -- remove the dir before cloning
   vim.fn.delete(packer_path, "rf")
   vim.fn.system {
      "git",
      "clone",
      "https://github.com/wbthomason/packer.nvim",
      "--depth",
      "20",
      packer_path,
   }

   cmd "packadd packer.nvim"
   present, packer = pcall(require, "packer")

   if present then
      print "Packer cloned successfully."
   else
      error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
   end
end

packer.init {
   display = {
      prompt_border = "rounded",
      open_cmd = "silent topleft 65vnew",
   },
   git = {
      clone_timeout = 600, -- Timeout, in seconds, for git clones
   },
   max_jobs = 20,
   auto_clean = true,
   compile_on_sync = true,
   profile = {
      enable = true,
      threshold = 1,
   },
   --    auto_reload_compiled = true
}

return packer
