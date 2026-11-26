cask "smuggler" do
  version "1.1"
  sha256 "0de01a5b6d47f1888da5673f7b03fe57f90f72feaa7831a122c5f39569d3b053"

  url "https://github.com/benjaminhuebner/Smuggler/releases/download/v#{version}/Smuggler.dmg"
  name "Smuggler"
  desc "Utility to remove the quarantine attribute from downloaded files"
  homepage "https://smuggler.benjaminhuebner.com/"

  livecheck do
    url "https://github.com/benjaminhuebner/Smuggler/releases/latest/download/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :tahoe

  app "Smuggler.app"

  uninstall quit: "com.benjaminhuebner.Smuggler"

  zap trash: [
    "~/Library/Application Scripts/com.benjaminhuebner.Smuggler.FinderExtension",
    "~/Library/Application Scripts/F6A5PBNZF2.group.com.benjaminhuebner.Smuggler",
    "~/Library/Caches/com.benjaminhuebner.Smuggler",
    "~/Library/Containers/com.benjaminhuebner.Smuggler.FinderExtension",
    "~/Library/Group Containers/F6A5PBNZF2.group.com.benjaminhuebner.Smuggler",
    "~/Library/HTTPStorages/com.benjaminhuebner.Smuggler",
    "~/Library/HTTPStorages/com.benjaminhuebner.Smuggler.binarycookies",
    "~/Library/Preferences/com.benjaminhuebner.Smuggler.FinderExtension.plist",
    "~/Library/Preferences/com.benjaminhuebner.Smuggler.plist",
  ]
end
