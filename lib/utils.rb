module Utils
  def wrap_cb(&block)
    -> (args) do
      block.call(*Native(args))
    end
  end
end