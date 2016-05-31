class Journey

  def initialize(entry_station = nil)
    @status = {}

    @status[:entry_station] = entry_station unless entry_station == nil
  end

  def finish(exit_station = nil)
    status[:exit_station] = exit_station unless exit_station == nil
    fare
    status
  end

  def fare
    complete? ? status[:fare] = 1 : status[:fare] = 6
  end

  def complete?
    [:entry_station,:exit_station].all? {|x| status.key?(x)}
  end

private
attr_reader :status

end
