--[[
  preview: https://www.youtube.com/watch?v=2vbf_4IMcCo
  you'll have to convert the code a bit, nothing serious.
  credits to outrowender for publishing the progress bar drawing method.
]]

Renderer.DrawStaticRect = function(x, y, w, h, r, g, b, a)
    local _w, _h = w / GUI.screen.w, h / GUI.screen.h
    local _x, _y = x / GUI.screen.w, y / GUI.screen.h
    Citizen.InvokeNative(0x3A618A217E5154F0,_x, _y, _w, _h, r, g, b, a)
end

Renderer.drawProgressBar = function(x, y, width, height, colour, percent, max_value)
    if (percent > max_value) then
        percent = max_value
    end
    local w = width * (percent/max_value)
    local x = (x - (width * (percent/max_value))/2)-width/2    
    Renderer.DrawStaticRect(x+w, y, w, height, colour[1], colour[2], colour[3], colour[4])
end

drawSpeedo = function(vehicle)
    if (vehicle and DoesEntityExist(vehicle)) then
        local center_screen_size_x, center_screen_size_y = GUI.screen.w / 2, GUI.screen.h / 2
        Renderer.DrawRect(center_screen_size_x - 2, center_screen_size_y - 2, 83, 70, UI.style.Background_Outline_Border.r, UI.style.Background_Outline_Border.g, UI.style.Background_Outline_Border.b, 255)
        Renderer.DrawRect(center_screen_size_x - 1, center_screen_size_y - 1, 81, 68, UI.style.Background_Border.r, UI.style.Background_Border.g, UI.style.Background_Border.b, 255)
        Renderer.DrawRect(center_screen_size_x, center_screen_size_y, 79, 66, UI.style.Background.r, UI.style.Background.g, UI.style.Background.b, 255)
        
        local pressure = nertigel["math"]["round"](GetVehicleTurboPressure(vehicle) * 100, 2)
        if (pressure >= 0) then
            Renderer.drawProgressBar(center_screen_size_x + 40, center_screen_size_y + 10, 69, 10, {55, 255, 55, 255}, pressure, 100)
        else
            Renderer.drawProgressBar(center_screen_size_x + 40, center_screen_size_y + 10, 69, 10, {255, 55, 55, 255}, pressure + 100, 100)
        end
        
        Renderer.drawProgressBar(center_screen_size_x + 40, center_screen_size_y + 10 + 15, 69, 10, {55, 55, 255, 255}, GetVehicleCurrentGear(vehicle), GetVehicleHighGear(vehicle))
        Renderer.drawProgressBar(center_screen_size_x + 40, center_screen_size_y + 10 + 30, 69, 10, {255, 255, 55, 255}, GetEntitySpeed(vehicle) * 3.6, GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel"))
        Renderer.drawProgressBar(center_screen_size_x + 40, center_screen_size_y + 10 + 45, 69, 10, {255, 255, 55, 255}, GetVehicleCurrentRpm(vehicle), 1.0)
    end
end
