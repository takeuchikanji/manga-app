class Recommend < ActiveHash::Base
  self.data = [
    {id: 1, name: 'おすすめにする'}, 
    {id: 2, name: 'おすすめにしない'}
  ]
end