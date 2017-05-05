# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Groups = Group.create([
							{name:"Administrador"},
							{name:"User"}
					 ])

Actions = Action.create([
							{name:"index"},
							{name:"show"},
							{name:"create"},
							{name:"update"},
							{name:"destroy"}
						])

Controls = Control.create([
 							{name:"Action",actions:[1,2,3,4,5]},
 							{name:"Attachment",actions:[1,2,3,4,5]},
 							{name:"Control",actions:[1,2,3,4,5]},
 							{name:"Group",actions:[1,2,3,4,5]},
 							{name:"Permission",actions:[1,2,3,4,5]},
 							{name:"Product",actions:[1,2,3,4,5]},
 							{name:"Token",actions:[1,2,3,4,5]},
 							{name:"User",actions:[1,2,3,4,5]}
 						 ])

Permisssions = Permission.create([
									{group_id:1,control_id:1,action_id:1},
									{group_id:1,control_id:1,action_id:2},
									{group_id:1,control_id:1,action_id:3},
									{group_id:1,control_id:1,action_id:4},
									{group_id:1,control_id:1,action_id:5},
									{group_id:1,control_id:2,action_id:1},
									{group_id:1,control_id:2,action_id:2},
									{group_id:1,control_id:2,action_id:3},
									{group_id:1,control_id:2,action_id:4},
									{group_id:1,control_id:2,action_id:5},
									{group_id:1,control_id:3,action_id:1},
									{group_id:1,control_id:3,action_id:2},
									{group_id:1,control_id:3,action_id:3},
									{group_id:1,control_id:3,action_id:4},
									{group_id:1,control_id:3,action_id:5},
									{group_id:1,control_id:4,action_id:1},
									{group_id:1,control_id:4,action_id:2},
									{group_id:1,control_id:4,action_id:3},
									{group_id:1,control_id:4,action_id:4},
									{group_id:1,control_id:4,action_id:5},
									{group_id:1,control_id:5,action_id:1},
									{group_id:1,control_id:5,action_id:2},
									{group_id:1,control_id:5,action_id:3},
									{group_id:1,control_id:5,action_id:4},
									{group_id:1,control_id:5,action_id:5},
									{group_id:1,control_id:6,action_id:3},
									{group_id:1,control_id:6,action_id:4},
									{group_id:1,control_id:6,action_id:5}
								])