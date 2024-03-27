defmodule Demo.SpacesTest do
  use Demo.DataCase

  alias Demo.Spaces

  describe "spaces" do
    alias Demo.Spaces.Space

    import Demo.SpacesFixtures

    @invalid_attrs %{name: nil}

    test "list_spaces/0 returns all spaces" do
      space = space_fixture()
      assert Spaces.list_spaces() == [space]
    end

    test "get_space!/1 returns the space with given id" do
      space = space_fixture()
      assert Spaces.get_space!(space.id) == space
    end

    test "create_space/1 with valid data creates a space" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Space{} = space} = Spaces.create_space(valid_attrs)
      assert space.name == "some name"
    end

    test "create_space/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spaces.create_space(@invalid_attrs)
    end

    test "update_space/2 with valid data updates the space" do
      space = space_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Space{} = space} = Spaces.update_space(space, update_attrs)
      assert space.name == "some updated name"
    end

    test "update_space/2 with invalid data returns error changeset" do
      space = space_fixture()
      assert {:error, %Ecto.Changeset{}} = Spaces.update_space(space, @invalid_attrs)
      assert space == Spaces.get_space!(space.id)
    end

    test "delete_space/1 deletes the space" do
      space = space_fixture()
      assert {:ok, %Space{}} = Spaces.delete_space(space)
      assert_raise Ecto.NoResultsError, fn -> Spaces.get_space!(space.id) end
    end

    test "change_space/1 returns a space changeset" do
      space = space_fixture()
      assert %Ecto.Changeset{} = Spaces.change_space(space)
    end
  end
end
