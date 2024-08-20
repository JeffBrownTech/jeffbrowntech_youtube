
<#
    Global
      - This scope is available when you open a PowerShell console or create a new runspace or session.
      - PowerShell’s automatic and preference variables are present and available in the global scope.
      - Any variables, alias, and functions defined in your PowerShell profile are also available in the global scope.
    
    Script
      - This is the scope created when you run a script.
      - Variables defined in the script are only available to the script scope and not the global or parent scope.
    
    Local
      - This is the current scope of where a command or script is currently running.
      - For example, variables defined in a script scope is considered its local scope.
    
    Scopes work in a hierarchy:
      - Global is the parent scope.
      - Variables defined in the global scope are available to child scopes.
      - Variable defined in the child scope are not available to the parent scope.
      - Variables cannot be changed outside of their scope.
#>

<#
Global Scope vs. Script Scope

Examine the ScriptScope.ps1 file in this same directory. It defines $greeting and outputs to the console.

Run the script and examine the output.
#>

.\ScriptScope.ps1

# Try and output $greeting now in the global scope, it should be empty/null.
# This is because it is defined with the child scope (the ScriptScope.ps1 scope) and not the global scope.
$greeting

# Define another variable here ($greeting2) and see its output
$greeting2 = "Hello from the global scope!"
$greeting2

# Run ScriptScopeWithGlobal.ps1
.\ScriptScopeWithGlobal.ps1

# Scope modifiers can change the defined variable scope
# Modifiers include: global:, local:, private:, and script:
# Review and run the ScriptScopeDefineGlobalVariable.ps1
.\GlobalVariableDefined.ps1

# Now try to output the variable defined from the script in the global scope, it should display since it is now global
$greetingGlobal

# You can use dot source notation to include a script or function's variables into the global scope
# Output $greeting, it should be blank/null
$greeting

# Dot source ScriptScope.ps1 to bring in value of $greeting
. .\ScriptScope.ps1

# Output $greeting again, it's value is now in the global scope
$greeting