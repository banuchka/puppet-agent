component "virt-what" do |pkg, settings, platform|
  pkg.version "1.1.4"
  pkg.md5sum "4d9bb5afc81de31f66443d8674bb3672"
  pkg.url "http://systmain1.mlan/virt-what-1.14.tar.gz"

  pkg.replaces 'pe-virt-what'

  # Run-time requirements
  unless platform.is_deb?
    requires "util-linux"
  end
  if platform.name =~ /^sles-(10|11)-.*$/
    requires "pmtools"
  end

  if platform.is_rpm?
    pkg.build_requires "util-linux"
  end

  if platform.is_linux?
    if platform.architecture =~ /ppc64le$/
      target = 'powerpc64le-unknown-linux-gnu'
    end
  end

  pkg.configure do
    ["./configure --prefix=#{settings[:prefix]} --sbindir=#{settings[:prefix]}/bin --libexecdir=#{settings[:prefix]}/lib/virt-what #{target}"]
  end

  pkg.build do
    ["#{platform[:make]} -j$(shell expr $(shell #{platform[:num_cores]}) + 1)"]
  end

  pkg.install do
    ["#{platform[:make]} -j$(shell expr $(shell #{platform[:num_cores]}) + 1) install"]
  end
end
