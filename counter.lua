-- Contatore di @LupiCattivi

-- */WARNING\*
--if you try to copy and paste this code your computer WILL EXPLODE
--Instead, you could understand the code here to learn how to use it.

obs = obslua

Counter_name = "Contatore_di_Lupi"
Initial_counter_value = "0"

-- Identifier of the hotkey set by OBS
hotkey_id = obs.OBS_INVALID_HOTKEY_ID

function script_description()
  print("description loaded")
  return [[Contatore di LupiCattivi
  
Un utile strumento con cui contare i lupi che entrano nel recinto prima di addormentarvi.
Se volete potete usarlo come DEATHCOUNTER.

Istruzioni: creare una fonte di testo chiamata "Contatore_di_Lupi"]]

end

function change_counter_value(counting, value)
  result_num = 0
  local source = obs.obs_get_source_by_name(Counter_name)
  if source ~= nil then
    local source_settings = obs.obs_source_get_settings(source)
    
    if counting == true then
      result_num = increment_by(value, source_settings)

    end

      obs.obs_data_set_string(source_settings, "text", result_num)
      obs.obs_source_update(source, source_settings)

      obs.obs_data_release(source_settings)
      obs.obs_source_release(source)
  end

end

function increment_by(value, source_settings)
  local source_text = obs.obs_data_get_string(source_settings, "text")
    if source_text ~= nil then
      
      if tonumber(source_text) ~= nil then
        return tonumber(source_text) + value
      
      else
        return 0

      end
      
    return 0

  end
  
end

function script_load(settings)
  hotkey_id = obs.obs_hotkey_register_frontend(script_path(), "Add 1 Wolf", on_hotkey)
  local hotkey_save_array = obs.obs_data_get_array(settings, "Increment")
  obs.obs_hotkey_load(hotkey_id, hotkey_save_array)
  obs.obs_data_array_release(hotkey_save_array)

end

function on_hotkey(pressed)
  if pressed then
    change_counter_value(true, 1)
  end
end

function script_save(settings)
  obs.obs_save_sources()

  -- Hotkey save
  local hotkey_save_array = obs.obs_hotkey_save(hotkey_id)
  obs.obs_data_set_array(settings, "Increment", hotkey_save_array)
  obs.obs_data_array_release(hotkey_save_array)
end

-- PROPRIETIES
-- function script_properties()
--   props = obs.obs_properties_create()
--   return props
-- end    
