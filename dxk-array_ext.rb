class Array
  def normalize(scale = 1)
    cur_max = self.max
    if scale != 1
      return self.map{|i| (i.to_f * scale)/cur_max}
    else
      return self.map{|i| i.to_f/cur_max}
    end
  end

  def pdf(scale = 1)
    cur_sum = self.inject(0, :+)
    if scale != 1
      return self.map{|i| (i.to_f * scale)/cur_sum}
    else
      return self.map{|i| i.to_f/cur_sum}
    end
  end
  
  def cdf(scale = 1)
    cur_sum = 0
    return self.map{|i| cur_sum += i}.normalize(scale)
  end

  def wsample(weights, n = 1)
    cur_len = self.length
    w_len = weights.length
    ret = []
    n = (n > cur_len ? cur_len : (n < 1 ? 1 : n)).to_i
    weights = weights + [0] * (cur_len - w_len) if w_len < cur_len
    normalized = weights[0...cur_len].cdf
    n.times do
      idx = n -1
      cur_rand = rand()
      normalized.each_with_index do |val, i|
        idx = i
        if cur_rand < val
          idx = i
          break
        end
      end
      ret =ret + [self[idx]]
    end
    if n <= 1
      return ret[0]
    else
      return ret
    end
  end
end
 
