json.array!(@monsters) do |monster|
  json.extract! monster, :id, :name, :power, :element
  json.team do
    json.extract! monster.team, :id, :name if monster.team
  end
  json.url monster_url(monster, format: :json)
end
