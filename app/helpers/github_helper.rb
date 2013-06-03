module GithubHelper
  def profile_link(username)
    "http://github.com/#{username}"
  end

  def repo_link(username, repo, add_at_sign = false)
    link = "http://github.com/"
    link += "@" if add_at_sign
    link += "#{username}/#{repo}"
  end
end