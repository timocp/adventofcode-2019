class BFS
  def self.search(problem)
    queue = [problem.start_state]
    meta = { problem.start_state => nil } # map of child state back to parent states

    while (parent_state = queue.shift)
      return construct_path(parent_state, meta) if problem.goal?(parent_state)

      problem.each_successor(parent_state) do |child_state, action|
        next if meta.key?(child_state)

        meta[child_state] = [parent_state, action]
        queue.push child_state
      end
    end
    nil # no paths to a goal state
  end

  def self.construct_path(state, meta)
    action_list = []
    while (row = meta[state])
      state, action = row
      action_list.unshift action
    end
    action_list
  end
end
