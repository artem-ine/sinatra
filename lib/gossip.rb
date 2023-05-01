class Gossip
  attr_accessor :author, :content

  def initialize(gossip_author, gossip_content)
    @author = gossip_author
    @content = gossip_content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.save_all(gossips)
    CSV.open("./db/gossip.csv", "wb") do |csv|
      gossips.each do |gossip|
        csv << [gossip.author, gossip.content]
      end
    end
  end  

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    all_gossips = Gossip.all
    if id >= 0 && id < all_gossips.length
      return all_gossips[id]
    else
      return nil
    end
  end

  def update(updated_author, updated_content)
    all_gossips = self.class.all
    all_gossips.each do |gossip|
      if gossip.author == self.author && gossip.content == self.content
        gossip.author = updated_author
        gossip.content = updated_content
      end
    end
    self.class.save_all(all_gossips)
  end
  
end
