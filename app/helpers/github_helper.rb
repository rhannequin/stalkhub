module GithubHelper
  def profile_link(username)
    "http://github.com/#{username}"
  end

  def repo_link(username, repo)
    "http://github.com/#{username}/#{repo}"
  end
end