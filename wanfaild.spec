Name:           wanfaild
Version:        0.05
Release:        1%{?dist}
Summary:        Monitor WAN links and provide failover
License:        GPL+
Group:          Development/Libraries
URL:            http://github.com/silug/wanfaild
Source0:        http://github.com/downloads/silug/wanfaild/wanfaild-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch
BuildRequires:  perl(Module::Build)
BuildRequires:  perl(Test::More)
BuildRequires:  perl(Test::Pod) >= 1.00
BuildRequires:  perl(YAML::Tiny)
Requires:       perl(YAML::Tiny)
Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))
Requires(post):    chkconfig
Requires(preun):   chkconfig
Requires(preun):   initscripts
Requires(postun):  initscripts


%description
wanfaild will monitor one or more WAN links and provide failover support.

%prep
%setup -q

%build
%{__perl} Build.PL installdirs=vendor --install_path init=%{_initrddir}
./Build

%install
rm -rf $RPM_BUILD_ROOT

./Build install destdir=$RPM_BUILD_ROOT create_packlist=0
find $RPM_BUILD_ROOT -depth -type d -exec rmdir {} 2>/dev/null \;

touch $RPM_BUILD_ROOT/%{_sysconfdir}/%{name}.yml

%{_fixperms} $RPM_BUILD_ROOT/*

%check
./Build test

%clean
rm -rf $RPM_BUILD_ROOT

%post
/sbin/chkconfig --add %{name}

%preun
if [ "$1" = 0 ]; then
    /sbin/service %{name} stop
    /sbin/chkconfig --del %{name}
fi

%postun
if [ "$1" -ge 1 ]; then
    /sbin/service %{name} condrestart >/dev/null 2>&1
fi

%files
%defattr(-,root,root,-)
%doc COPYING README TODO samples/
%{_bindir}/*
%{_mandir}/man1/*
%{_initrddir}/%{name}
%ghost %config(noreplace) %{_sysconfdir}/%{name}.yml

%changelog
* Mon Apr 29 2013 Steven Pritchard <steve@kspei.com> 0.05-1
- Update to 0.05.

* Fri Apr 16 2010 Steven Pritchard <steve@kspei.com> 0.04-1
- Update to 0.04.

* Fri Apr 16 2010 Steven Pritchard <steve@kspei.com> 0.03-1
- Specfile autogenerated by cpanspec 1.79.
- Remove extra Test::* dependencies.
- Fix Source0 and URL.
- Fix files list to include bindir and man1.
- Add samples/ to docs.
- Add init script with post/preun/postun scripts.
- Add config file.
