# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

articles = [
  {
    :name => "Cif Detergente c/ Dosificador",
    :price => 10
  },

  {
    :name => "Fideos Marolio",
    :price => 2
  },

  {
    :name => "Papas Fritas Lays x 150g",
    :price => 6.9
  },

  {
    :name => "Queso Mantecoso",
    :price => 7.8
  },

  {
    :name => "Cunnington Tonica 2.25lts",
    :price => 3.9
  },

  {
    :name => "Alfajor Shot",
    :price => 2.33
  },

  {
    :name => "Pre Pizza",
    :price => 4.29
  },

  {
    :name => "Lustramuebles",
    :price => 6.99
  },

  {
    :name => "Detergente Magistral",
    :price => 11.48
  },

  {
    :name => "Suavizante Ropa Dia a Dia",
    :price => 3.5
  },
  
  {
    :name => "Mr Musculo Multiuso",
    :price => 3.19
  },
  
  {
    :name => "Detergente ropa negra",
    :price => 9.59
  },

  {
    :name => "Protectores Diarios",
    :price => 6.29
  },

  {
    :name => "Pañuelos Campanita",
    :price => 3.79
  },

  {
    :name => "Desodorante Rexona",
    :price => 8.02
  },

  {
    :name => "Desodorante Patrichs",
    :price => 7.75
  },

  {
    :name => "Alcohol en Gel (Repuesto)",
    :price => 6.99
  },

  {
    :name => "Talco Dr. Scholl (Repuesto)",
    :price => 9.99
  },

  {
    :name => "Talco Polyana",
    :price => 2.63
  },

  {
    :name => "Jabon Ariel Liquido",
    :price => 12.29
  },

  {
    :name => "Mr Musculo Antigrasa",
    :price => 4.79
  },

  {
    :name => "Pasta dentifrica Colgate",
    :price => 7.45
  },

  {
    :name => "Te Rojo Patagonia",
    :price => 5.16
  },

  {
    :name => "Te de Boldo La Morenita",
    :price => 2.09
  },

  {
    :name => "Mermelada",
    :price => 5.45
  },

  {
    :name => "Leche en Polvo SanCor",
    :price => 14.59
  },

  {
    :name => "Yerba Cachamate",
    :price => 5.49
  },

  {
    :name => "Arroz Molinos Ala",
    :price => 4.79
  },
  
  {
    :name => "Fideos Tirabuzon Luchetti",
    :price => 4.19
  },

  {
    :name => "Jardinera Arcor",
    :price => 3.49
  },

  {
    :name => "Atún Carefour",
    :price => 7.95
  }
]

articles.each do |article|
  Article.find_or_create_by_name(article[:name])
end
