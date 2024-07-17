# PowerShell Profile with Oh-My-Posh, Zig Completion, and Git Completion

This README provides an overview of setting up a PowerShell profile enhanced with Oh-My-Posh for a customized terminal experience, Zig language terminal commands completion for efficient coding, and Git completion for streamlined version control operations, leveraging the work by [`danialmd81`](https://github.com/danialmd81).

## Features

- **Oh-My-Posh Integration**: Customize your PowerShell terminal with themes and prompts that provide essential information at a glance.
- **Zig Terminal Commands Completion**: Get auto-completion for Zig language commands directly in your terminal, speeding up your development workflow.
- **Git Completion**: Utilize Git command completions to streamline your version control operations, making it easier to remember and type commands.

## Setup

### Oh-My-Posh

1. Install Oh-My-Posh:

    ```powershell
    winget install JanDeDobbeleer.OhMyPosh -s winget
    ```

2. Choose a theme and configure it in your PowerShell profile (just change the relative address in `./Microsoft.PowerShell_profile.ps1` first line).

### Zig Completion

1. Ensure Zig is installed and accessible from your PATH.

2. Add Zig completion script to your PowerShell profile

---

### Git Completion

1. Install `posh-git` module:

    ```powershell
    Install-Module -Name posh-git
    ```

2. Add the following to your PowerShell profile:

    ```powershell
    Import-Module posh-git 
    ```

---

### Conclusion

Enhancing your PowerShell profile with Oh-My-Posh, Zig terminal commands completion, and Git completion can significantly improve your terminal experience and productivity. Follow the steps outlined above to set up your environment.
