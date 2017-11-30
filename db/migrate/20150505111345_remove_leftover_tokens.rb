class RemoveLeftoverTokens < ActiveRecord::Migration[4.2]
  def up
    existing_tokens = Host::Managed.all.map(&:token).compact
    if existing_tokens.empty?
      Token.delete_all
    else
      Token.where('id not in (?)', existing_tokens).delete_all
    end
  end

  def down
  end
end
