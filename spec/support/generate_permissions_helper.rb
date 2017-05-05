module GeneratePermissionSpecHelpers

	def permissions
	  	Group.create([
						{name:"Administrador"},
						{name:"User"}
					])

		Action.create([
									{name:"index"},
									{name:"show"},
									{name:"create"},
									{name:"update"},
									{name:"destroy"}
								])

		Control.create([
		 							{name:"Action",actions:[1,2,3,4,5]},
		 							{name:"Attachment",actions:[1,2,3,4,5]},
		 							{name:"Control",actions:[1,2,3,4,5]},
		 							{name:"Group",actions:[1,2,3,4,5]},
		 							{name:"Permission",actions:[1,2,3,4,5]},
		 							{name:"Product",actions:[1,2,3,4,5]},
		 							{name:"Token",actions:[1,2,3,4,5]},
		 							{name:"User",actions:[1,2,3,4,5]}
		 						 ])

		Permission.create([
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
	end

end