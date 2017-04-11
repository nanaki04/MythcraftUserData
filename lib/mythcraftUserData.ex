defmodule MythcraftUserData do
  @storage_path "storage/"

  def save_gamestate(game_id, exported_gamestate) do
    {:ok, file} = :dets.open_file get_filename(game_id), []

    try do
      :dets.insert file, {:gamestate, exported_gamestate}
    after
      :dets.close file
    end
  end

  def get_gamestate(game_id) do
    {:ok, file} = :dets.open_file get_filename(game_id)

    try do
      [gamestate: gamestate] = :dets.lookup file, :gamestate
      gamestate
    after
      :dets.close file
    end
  end

  defp get_filename(game_id) do
    @storage_path <> game_id
  end

end
