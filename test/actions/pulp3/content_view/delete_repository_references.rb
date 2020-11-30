require 'katello_test_helper'

module ::Actions::Pulp3::ContentView
  class DeleteRepositoryReferenceTest < ActiveSupport::TestCase
    include Katello::Pulp3Support

    def setup
      @master = FactoryBot.create(:smart_proxy, :default_smart_proxy, :with_pulp3)
      @repo = katello_repositories(:generic_file_archive)
      @content_view = @repo.content_view
      ensure_creatable(@repo, @master)
    end

    def test_create
      ForemanTasks.sync_task(::Actions::Pulp3::Orchestration::Repository::Create, @repo, @master)
      repo_reference = Katello::Pulp3::RepositoryReference.find_by(:content_view => @content_view, :root_repository_id => @repo.root.id)
      library_repo_ref = Katello::Pulp3::RepositoryReference.create!(:root_repository_id => @repo.root.id, :content_view_id => @repo.library_instance.content_view.id, :repository_href => '/some/fake/href')

      assert repo_reference
      assert Katello::Pulp3::Api::File.new(@master).repositories_api.read(repo_reference.repository_href)

      ForemanTasks.sync_task(::Actions::Pulp3::ContentView::DeleteRepositoryReferences, @content_view, @master)
      refute Katello::Pulp3::RepositoryReference.find_by(:id => repo_reference.id)
      assert Katello::Pulp3::RepositoryReference.find_by(:id => library_repo_ref.id)
      assert_raises(PulpFileClient::ApiError) do
        Katello::Pulp3::Api::File.new(@master).repositories_api.read(repo_reference.repository_href)
      end
    end
  end
end