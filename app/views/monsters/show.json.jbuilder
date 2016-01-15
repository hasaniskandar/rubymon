json.extract! @monster, :id, :name, :power, :element, :weakness
json.team do
  json.extract! @monster.team, :id, :name if @monster.team
end
