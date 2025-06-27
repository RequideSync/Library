# Wizard Lib

## Library
```lua
local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/RequideSync/Library/refs/heads/main/Wizard/Scr/Main.lua"))()
```

## Window
```lua
local Window = Library:NewWindow("Combat")
```

## Section
```lua
local Section = Window:NewSection("Option")
```

## Button
```lua
Section:CreateButton("Button", function()
    print("HI")
end)
```

## Text Box
```lua
Section:CreateTextbox("TextBox", function(text)
    print(text)
end)
```

## Toggle
```lua
Section:CreateToggle("Auto Ez", function(value)
    print(value)
end)
```

## Dropdown
```lua
Section:CreateDropdown("DropDown", {"Hello", "World", "Hello World"}, 2, function(text)
    print(text)
end)
```

## Dropdown
```lua
Section:CreateSlider("Slider", 0, 100, 15, false, function(value)
    print(value)
end)
```
