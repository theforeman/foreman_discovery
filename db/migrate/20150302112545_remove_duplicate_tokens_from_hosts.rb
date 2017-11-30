class RemoveDuplicateTokensFromHosts < ActiveRecord::Migration[4.2]
  def up
    Token.where('id not in (?)', Host::Managed.all.map(&:token).compact).delete_all
  end

  def down
  end
end
