= FileSystem Rover

A simple webapp for your filesystem.
- Runs as root, authenticates via PAM
- Login as root can be allowed via [configuration]('#configuration')
- Allows browsing the filesystem
- Permissions are shown for convenience
- Uses File/Directory read/write permissions as defined for the system user
- For text files with read+write permissions, allows editing in the browser
- For all text and binary files with read permissions, allows downloading (but not for non-filetypes like `characterSpecial`, `blockSpecial`, `fifo`, `socket`, or `unknown`)
- Symlinks, wherever present, are followed and the underlying file is used

== Notes

- ActiveRecord/DB functionality has been stripped out, because this project is primarily for interaction with the filesystem
- Backend authorization works via setting and resetting EUID of the server process to the signed-in user. This is why a process-forking model based server like unicorn is recommended for this project, instead of a threaded server such as thin/puma.
- Read access to the signed-in user's home directory is assumed to be available, and set as the default navigation path
- All exceptions related to filesystem access are caught and redirected to the home directory with error details
- All unhandled exceptions are redirected to the login page with error details
- In all exception cases, the EUID of the process is reset

== Ruby version
2.2.2

== System dependencies
The file(1) library and headers are required:

- Debian/Ubuntu:: +libmagic-dev+
- Fedora/SuSE::   +file-devel+
- Gentoo::        +sys-libs/libmagic+
- OS X::          <tt>brew install libmagic</tt>

pam-devel and ruby-devel headers are required:

On Red Hat/Fedora based systems:

- yum install pam-devel

- yum install ruby-devel

On Debian/Ubuntu based systems:

- apt-get install libpam0g-dev

- apt-get install ruby1.9-dev

Note: If you're using rvm/rbenv, the ruby development headers will be installed in the correct path by default, so don't worry about the Ruby development libraries.

== Configuration

To allow root user to login, change the value of `allow_root_login` in `config/application.rb`

== Deployment instructions

- [rbenv](https://github.com/sstephenson/rbenv) and [rbenv-sudo](https://github.com/dcarley/rbenv-sudo) are recommended, though a standard ruby install should work just as well
- Make sure you have file + libmagic installed. See System dependencies
- Make sure you have ruby 2.2.2 installed

```bash
# Make sure you have the bundler gem installed - gem install bundler (use sudo for systemwide ruby)
git clone https://github.com/shirshendu/fs-rover.git
cd fs-rover
bundle install --path vendor/bundle # or skip the path if you like
rbenv sudo bundle exec rails server # I use rbenv-sudo. If you have installed ruby and bundler as root, su into root and run bundle exec rails server
```

If deploying in production mode, make sure to set your `SECRET_KEY_BASE` environment variable. See `config/secrets.yml`


