

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title>
  Netzuela / Spuria / source &mdash; Bitbucket
</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="description" content="" />
  <meta name="keywords" content="" />
  <!--[if lt IE 9]>
  <script src="https://dwz7u9t8u8usb.cloudfront.net/m/1a1b57f0564b/js/lib/html5.js"></script>
  <![endif]-->

  <script>
    (function (window) {
      // prevent stray occurrences of `console.log` from causing errors in IE
      var console = window.console || (window.console = {});
      console.log || (console.log = function () {});

      var BB = window.BB || (window.BB = {});
      BB.debug = false;
      BB.cname = false;
      BB.CANON_URL = 'https://bitbucket.org';
      BB.MEDIA_URL = 'https://dwz7u9t8u8usb.cloudfront.net/m/1a1b57f0564b/';
      BB.images = {
        invitation: 'https://dwz7u9t8u8usb.cloudfront.net/m/1a1b57f0564b/img/icons/fugue/card_address.png',
        noAvatar: 'https://dwz7u9t8u8usb.cloudfront.net/m/1a1b57f0564b/img/no_avatar.png'
      };
      BB.user = {"username": "Netzuela", "displayName": "N\u00e9stor Boh\u00f3rquez", "firstName": "N\u00e9stor", "avatarUrl": "https://secure.gravatar.com/avatar/8bdf196e4e061ac151b4cca7368859c5?d=identicon&s=32", "follows": {"repos": [640038, 640085, 642971]}, "isSshEnabled": true, "lastName": "Boh\u00f3rquez", "isKbdShortcutsEnabled": true, "id": 293544};
      BB.user.has = (function () {
        var betaFeatures = [];
        betaFeatures.push('repo2');
        return function (feature) {
          return _.contains(betaFeatures, feature);
        };
      }());
      BB.targetUser = BB.user;
  
      BB.repo || (BB.repo = {});
  
      
        BB.user.repoPrivilege = "admin";
      
      
      BB.repo.id = 640038;
    
    
      BB.repo.language = 'sql';
      BB.repo.pygmentsLanguage = 'sql';
    
    
      BB.repo.slug = 'spuria';
    
    
      BB.repo.owner = {
        username: 'Netzuela'
      };
    
    
    
      // Coerce `BB.repo` to a string to get
      // "davidchambers/mango" or whatever.
      BB.repo.toString = function () {
        return BB.cname ? this.slug : '{owner.username}/{slug}'.format(this);
      }
    
    
      BB.changeset = 'ca072108f145'
    
    
  
    }(this));
  </script>

  


  <link rel="stylesheet" href="https://dwz7u9t8u8usb.cloudfront.net/m/1a1b57f0564b/bun/css/bundle.css"/>



  <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="Bitbucket" />
  <link rel="icon" href="https://dwz7u9t8u8usb.cloudfront.net/m/1a1b57f0564b/img/logo_new.png" type="image/png" />
  <link type="text/plain" rel="author" href="/humans.txt" />


  
  
    <script src="https://dwz7u9t8u8usb.cloudfront.net/m/1a1b57f0564b/bun/js/bundle.js"></script>
  



</head>

<body id="" class=" ">
  <script>
    if (navigator.userAgent.indexOf(' AppleWebKit/') === -1) {
      $('body').addClass('non-webkit')
    }
    $('body')
      .addClass($.client.os.toLowerCase())
      .addClass($.client.browser.toLowerCase())
  </script>
  <!--[if IE 8]>
  <script>jQuery(document.body).addClass('ie8')</script>
  <![endif]-->
  <!--[if IE 9]>
  <script>jQuery(document.body).addClass('ie9')</script>
  <![endif]-->

  <div id="wrapper">



  <div id="header-wrap">
    <div id="header">
    <ul id="global-nav">
      <li><a class="home" href="http://www.atlassian.com">Atlassian Home</a></li>
      <li><a class="docs" href="http://confluence.atlassian.com/display/BITBUCKET">Documentation</a></li>
      <li><a class="support" href="/support">Support</a></li>
      <li><a class="blog" href="http://blog.bitbucket.org">Blog</a></li>
      <li><a class="forums" href="http://groups.google.com/group/bitbucket-users">Forums</a></li>
    </ul>
    <a href="/" id="logo">Bitbucket by Atlassian</a>

    <div id="main-nav">
    

      <ul class="clearfix">
        <li><a href="/explore" id="explore-link">Explore</a></li>
        <li><a href="https://bitbucket.org" id="dashboard-link">Dashboard</a></li>
        <li id="repositories-dropdown" class="inertial-hover active">
          <a class="drop-arrow" href="/repo/mine" id="repositories-link">Repositories</a>
          <div>
            <div>
              <div id="repo-overview"></div>
              <div class="group">
                <a href="/repo/create" class="new-repository" id="create-repo-link">Create repository</a>
                <a href="/repo/import" class="import-repository" id="import-repo-link">Import repository</a>
              </div>
            </div>
          </div>
        </li>
        <li id="user-dropdown" class="inertial-hover">
          <a class="drop-arrow" href="/Netzuela">
            <span>Néstor Bohórquez</span>
          </a>
          <div>
            <div>
              <div class="group">
                <a href="/account/user/Netzuela/" id="account-link">Account</a>
                <a href="/account/notifications/" id="inbox-link">Inbox</a>
                <a href="/account/signout/">Log out</a>
              </div>

    

            </div>
          </div>
        </li>
        

<li class="search-box">
  
    <form action="/repo/all">
      <input type="search" results="5" autosave="bitbucket-explore-search"
             name="name" id="searchbox"
             placeholder="owner/repo" />
  
  </form>
</li>

      </ul>

    
    </div>

  

    </div>
  </div>

    <div id="header-messages">
  
    
    
    
    
  

    
   </div>



    <div id="content">
      <div id="source">
      
  
  





  <script>
    jQuery(function ($) {
        var cookie = $.cookie,
            cookieOptions, date,
            $content = $('#content'),
            $pane = $('#what-is-bitbucket'),
            $hide = $pane.find('[href="#hide"]').css('display', 'block').hide();

        date = new Date();
        date.setTime(date.getTime() + 365 * 24 * 60 * 60 * 1000);
        cookieOptions = { path: '/', expires: date };

        if (cookie('toggle_status') == 'hide') $content.addClass('repo-desc-hidden');

        $('#toggle-repo-content').click(function (event) {
            event.preventDefault();
            $content.toggleClass('repo-desc-hidden');
            cookie('toggle_status', cookie('toggle_status') == 'show' ? 'hide' : 'show', cookieOptions);
        });

        if (!cookie('hide_intro_message')) $pane.show();

        $hide.click(function (event) {
            event.preventDefault();
            cookie('hide_intro_message', true, cookieOptions);
            $pane.slideUp('slow');
        });

        $pane.hover(
            function () { $hide.fadeIn('fast'); },
            function () { $hide.fadeOut('fast'); });

      (function () {
        // Update "recently-viewed-repos" cookie for
        // the "repositories" drop-down.
        var
          id = BB.repo.id,
          cookieName = 'recently-viewed-repos_' + BB.user.id,
          rvr = cookie(cookieName),
          ids = rvr? rvr.split(','): [],
          idx = _.indexOf(ids, '' + id);

        // Remove `id` from `ids` if present.
        if (~idx) ids.splice(idx, 1);

        cookie(
          cookieName,
          // Insert `id` as the first item, then call
          // `join` on the resulting array to produce
          // something like "114694,27542,89002,84570".
          [id].concat(ids.slice(0, 4)).join(),
          {path: '/', expires: 1e6} // "never" expires
        );
      }());
    });
  </script>




<div id="tabs" class="tabs">
  <ul>
    
      <li>
        <a href="/Netzuela/spuria" id="repo-overview-link">Overview</a>
      </li>
    

    
      <li>
        <a href="/Netzuela/spuria/downloads" id="repo-downloads-link">Downloads (<span id="downloads-count">0</span>)</a>
      </li>
    

    
      
    

    
      <li>
        <a href="/Netzuela/spuria/pull-requests" id="repo-pr-link">Pull requests (0)</a>
      </li>
    

    
      <li class="selected">
        
          <a href="/Netzuela/spuria/src" id="repo-source-link">Source</a>
        
      </li>
    

    
      <li>
        <a href="/Netzuela/spuria/changesets" id="repo-commits-link">Commits</a>
      </li>
    

    <li id="wiki-tab" class="dropdown"
      style="display:
            block 
        
      ">
      <a href="/Netzuela/spuria/wiki" id="repo-wiki-link">Wiki</a>
    </li>

    <li id="issues-tab" class="dropdown inertial-hover"
      style="display:
            block 
        
      ">
      <a href="/Netzuela/spuria/issues?status=new&amp;status=open" id="repo-issues-link">Issues (0) &raquo;</a>
      <ul>
        <li><a href="/Netzuela/spuria/issues/new">Create new issue</a></li>
        <li><a href="/Netzuela/spuria/issues?status=new">New issues</a></li>
        <li><a href="/Netzuela/spuria/issues?status=new&amp;status=open">Open issues</a></li>
        <li><a href="/Netzuela/spuria/issues?status=duplicate&amp;status=invalid&amp;status=resolved&amp; status=wontfix">Closed issues</a></li>
        
          <li><a href="/Netzuela/spuria/issues?responsible=Netzuela">My issues</a></li>
        
        <li><a href="/Netzuela/spuria/issues">All issues</a></li>
        <li><a href="/Netzuela/spuria/issues/query">Advanced query</a></li>
      </ul>
    </li>

    
        <li>
          <a href="/Netzuela/spuria/admin" id="repo-admin-link">Admin</a>
        </li>
    
  </ul>

  <ul>
    
      <li>
        <a href="/Netzuela/spuria/descendants" id="repo-forks-link">Forks/queues (1)</a>
      </li>
    

    
      <li>
        <a href="/Netzuela/spuria/zealots">Followers (<span id="followers-count">1</span>)</a>
      </li>
    
  </ul>
</div>




  <div id="invitation-dialog" title="Send an invitation">

<form class="invitation-form newform"
  method="post"
  action="/api/1.0/invitations/Netzuela/spuria"
  novalidate>
  <div style='display:none'><input type='hidden' name='csrfmiddlewaretoken' value='8e7b48f70b17e95517b98d2aeac76acc' /></div>
  <div class="error_ message_"><h4></h4></div>
  <div class="success_ message_"><h4></h4></div>
  <label for="id-email-address">Email address</label>
  <input type="email" id="id-email-address" name="email-address">
  <select name="permission" class="nosearch">
  
    <option value="read">Read access</option>
  
    <option value="write">Write access</option>
    <option value="admin">Admin access</option>
  </select>
  <input type="submit" value="Send invitation" />
</form>
</div>
 


  <div class="repo-menu" id="repo-menu">
    <ul id="repo-menu-links">
    
    
      <li>
        <a id="repo-invite-link" href="#share" class="share">invite</a>
      </li>
    
      <li>
        <a href="/Netzuela/spuria/rss?token=e0fe869d2a817016bc0ee30e85107e20" class="rss" title="RSS feed for Spuria">RSS</a>
      </li>

      <li><a id="repo-fork-link" href="/Netzuela/spuria/fork" class="fork">fork</a></li>
      
      <li>
        <a id="repo-follow-link" rel="nofollow" href="/Netzuela/spuria/follow" class="follow following">following</a>
      </li>
      
          
      
      
        <li class="get-source inertial-hover">
          <a class="source">get source</a>
          <ul class="downloads">
            
              
              <li><a rel="nofollow" href="/Netzuela/spuria/get/ca072108f145.zip">zip</a></li>
              <li><a rel="nofollow" href="/Netzuela/spuria/get/ca072108f145.tar.gz">gz</a></li>
              <li><a rel="nofollow" href="/Netzuela/spuria/get/ca072108f145.tar.bz2">bz2</a></li>
            
          </ul>
        </li>
      
      
    </ul>

  
    <ul class="metadata">
      
      
      
        <li class="branches inertial-hover">branches
          <ul>
            <li><a href="/Netzuela/spuria/src/ca072108f145" title="develop">develop</a>
              
              
              <a rel="nofollow" class="menu-compare"
                 href="/Netzuela/spuria/compare/develop..master"
                 title="Show changes between develop and the main branch.">compare</a>
              
            </li>
            <li><a href="/Netzuela/spuria/src/f0978d917a7f" title="master">master</a>
              
              
            </li>
          </ul>
        </li>
      
      
     
      
    </ul>
  
  </div>




<div class="repo-menu" id="repo-desc">
    <ul id="repo-menu-links-mini">
      

      
        <li>
          <a href="#share" class="share" title="Invite">invite</a>
        </li>
      
      <li>
        <a href="/Netzuela/spuria/rss?token=e0fe869d2a817016bc0ee30e85107e20" class="rss" title="RSS feed for Spuria"></a>
      </li>

      <li><a href="/Netzuela/spuria/fork" class="fork" title="Fork"></a></li>
      
      <li>
        <a rel="nofollow" href="/Netzuela/spuria/follow" class="follow following">following</a>
      </li>
      
          
      
      
        <li>
          <a class="source" title="Get source"></a>
          <ul class="downloads">
            
              
              <li><a rel="nofollow" href="/Netzuela/spuria/get/ca072108f145.zip">zip</a></li>
              <li><a rel="nofollow" href="/Netzuela/spuria/get/ca072108f145.tar.gz">gz</a></li>
              <li><a rel="nofollow" href="/Netzuela/spuria/get/ca072108f145.tar.bz2">bz2</a></li>
            
          </ul>
        </li>
      
    </ul>

    <h3 id="repo-heading" class="private git">
      <a class="owner-username" href="/Netzuela">Netzuela</a> /
      <a class="repo-name" href="/Netzuela/spuria">Spuria</a>
    

    
      <ul id="fork-actions" class="button-group">
      
      
        <li>
          <a id="repo-create-pr-link" href="/Netzuela/spuria/pull-request/new"
             class="icon pull-request">create pull request</a>
        </li>
      
      </ul>
    
    </h3>

    
      <p class="repo-desc-description">This is the core of Netzuela. It consists of the main database and important related software.

Es el núcleo del proyecto Netzuela. Está formado por la base de datos central y varias aplicaciones relacionadas importantes.</p>
    

  <div id="repo-desc-cloneinfo">Clone this repository (size: 10.5 MB):
    <a href="https://Netzuela@bitbucket.org/Netzuela/spuria.git" class="https">HTTPS</a> /
    <a href="ssh://git@bitbucket.org/Netzuela/spuria.git" class="ssh">SSH</a>
    
      <div id="sourcetree-clone-link" class="clone-in-client mac  help-activated"
          data-desktop-clone-url-ssh="sourcetree://cloneRepo/ssh://git@bitbucket.org/Netzuela/spuria.git"
          data-desktop-clone-url-https="sourcetree://cloneRepo/https://Netzuela@bitbucket.org/Netzuela/spuria.git">
         /
           <a class="desktop-ssh"
             href="sourcetree://cloneRepo/ssh://git@bitbucket.org/Netzuela/spuria.git">SourceTree</a>
           <a class="desktop-https"
             href="sourcetree://cloneRepo/https://Netzuela@bitbucket.org/Netzuela/spuria.git">SourceTree</a>
      </div>
    
    <pre id="clone-url-https">git clone https://Netzuela@bitbucket.org/Netzuela/spuria.git</pre>
    <pre id="clone-url-ssh">git clone git@bitbucket.org:Netzuela/spuria.git</pre>
    
  </div>

        <a href="#" id="toggle-repo-content"></a>

        

</div>






      
  <div id="source-container">
    

  <div id="source-path">
    <h1>
      <a href="/Netzuela/spuria/src" class="src-pjax">Spuria</a> /

  
    
      <a href="/Netzuela/spuria/src/ca072108f145/lib/" class="src-pjax">lib</a> /
    
  

  
    
      <span>hash_file.sh</span>
    
  

    </h1>
  </div>

  <div class="labels labels-csv">
  
    <dl>
  
    
  
  
    
  
  
    <dt>Branch</dt>
    
      
        <dd class="branch unabridged"><a href="/Netzuela/spuria/changesets/tip/develop" title="develop">develop</a></dd>
      
    
  
</dl>

  
  </div>


  
  <div id="source-view">
    <div class="header">
      <ul class="metadata">
        <li><code>ca072108f145</code></li>
        
          
            <li>102 loc</li>
          
        
        <li>2.4 KB</li>
      </ul>
      <ul class="source-view-links">
        
        <li><a href="/Netzuela/spuria/history/lib/hash_file.sh">history</a></li>
        
        <li><a href="/Netzuela/spuria/annotate/ca072108f145/lib/hash_file.sh">annotate</a></li>
        
        <li><a href="/Netzuela/spuria/raw/ca072108f145/lib/hash_file.sh">raw</a></li>
        <li>
          <form action="/Netzuela/spuria/diff/lib/hash_file.sh" class="source-view-form">
          
            <input type="hidden" name="diff2" value="ad600f335f2f" />
            <select name="diff1">
            
              
                <option value="ad600f335f2f">ad600f335f2f</option>
              
            
              
                <option value="12be5347b175">12be5347b175</option>
              
            
              
                <option value="180fe050458b">180fe050458b</option>
              
            
              
                <option value="f203a2411800">f203a2411800</option>
              
            
              
                <option value="5de66d25b608">5de66d25b608</option>
              
            
            </select>
            <input type="submit" value="diff" />
          
          </form>
        </li>
      </ul>
    </div>
  
    <div>
    <table class="highlighttable"><tr><td class="linenos"><div class="linenodiv"><pre><a href="#cl-1">  1</a>
<a href="#cl-2">  2</a>
<a href="#cl-3">  3</a>
<a href="#cl-4">  4</a>
<a href="#cl-5">  5</a>
<a href="#cl-6">  6</a>
<a href="#cl-7">  7</a>
<a href="#cl-8">  8</a>
<a href="#cl-9">  9</a>
<a href="#cl-10"> 10</a>
<a href="#cl-11"> 11</a>
<a href="#cl-12"> 12</a>
<a href="#cl-13"> 13</a>
<a href="#cl-14"> 14</a>
<a href="#cl-15"> 15</a>
<a href="#cl-16"> 16</a>
<a href="#cl-17"> 17</a>
<a href="#cl-18"> 18</a>
<a href="#cl-19"> 19</a>
<a href="#cl-20"> 20</a>
<a href="#cl-21"> 21</a>
<a href="#cl-22"> 22</a>
<a href="#cl-23"> 23</a>
<a href="#cl-24"> 24</a>
<a href="#cl-25"> 25</a>
<a href="#cl-26"> 26</a>
<a href="#cl-27"> 27</a>
<a href="#cl-28"> 28</a>
<a href="#cl-29"> 29</a>
<a href="#cl-30"> 30</a>
<a href="#cl-31"> 31</a>
<a href="#cl-32"> 32</a>
<a href="#cl-33"> 33</a>
<a href="#cl-34"> 34</a>
<a href="#cl-35"> 35</a>
<a href="#cl-36"> 36</a>
<a href="#cl-37"> 37</a>
<a href="#cl-38"> 38</a>
<a href="#cl-39"> 39</a>
<a href="#cl-40"> 40</a>
<a href="#cl-41"> 41</a>
<a href="#cl-42"> 42</a>
<a href="#cl-43"> 43</a>
<a href="#cl-44"> 44</a>
<a href="#cl-45"> 45</a>
<a href="#cl-46"> 46</a>
<a href="#cl-47"> 47</a>
<a href="#cl-48"> 48</a>
<a href="#cl-49"> 49</a>
<a href="#cl-50"> 50</a>
<a href="#cl-51"> 51</a>
<a href="#cl-52"> 52</a>
<a href="#cl-53"> 53</a>
<a href="#cl-54"> 54</a>
<a href="#cl-55"> 55</a>
<a href="#cl-56"> 56</a>
<a href="#cl-57"> 57</a>
<a href="#cl-58"> 58</a>
<a href="#cl-59"> 59</a>
<a href="#cl-60"> 60</a>
<a href="#cl-61"> 61</a>
<a href="#cl-62"> 62</a>
<a href="#cl-63"> 63</a>
<a href="#cl-64"> 64</a>
<a href="#cl-65"> 65</a>
<a href="#cl-66"> 66</a>
<a href="#cl-67"> 67</a>
<a href="#cl-68"> 68</a>
<a href="#cl-69"> 69</a>
<a href="#cl-70"> 70</a>
<a href="#cl-71"> 71</a>
<a href="#cl-72"> 72</a>
<a href="#cl-73"> 73</a>
<a href="#cl-74"> 74</a>
<a href="#cl-75"> 75</a>
<a href="#cl-76"> 76</a>
<a href="#cl-77"> 77</a>
<a href="#cl-78"> 78</a>
<a href="#cl-79"> 79</a>
<a href="#cl-80"> 80</a>
<a href="#cl-81"> 81</a>
<a href="#cl-82"> 82</a>
<a href="#cl-83"> 83</a>
<a href="#cl-84"> 84</a>
<a href="#cl-85"> 85</a>
<a href="#cl-86"> 86</a>
<a href="#cl-87"> 87</a>
<a href="#cl-88"> 88</a>
<a href="#cl-89"> 89</a>
<a href="#cl-90"> 90</a>
<a href="#cl-91"> 91</a>
<a href="#cl-92"> 92</a>
<a href="#cl-93"> 93</a>
<a href="#cl-94"> 94</a>
<a href="#cl-95"> 95</a>
<a href="#cl-96"> 96</a>
<a href="#cl-97"> 97</a>
<a href="#cl-98"> 98</a>
<a href="#cl-99"> 99</a>
<a href="#cl-100">100</a>
<a href="#cl-101">101</a>
<a href="#cl-102">102</a>
</pre></div></td><td class="code"><div class="highlight"><pre><a name="cl-1"></a><span class="c">#!/bin/bash</span>
<a name="cl-2"></a><span class="nb">declare</span> -A <span class="nv">TAMANOS</span><span class="o">=([</span><span class="s2">&quot;grandes&quot;</span><span class="o">]=</span><span class="s2">&quot;500&quot;</span> <span class="o">[</span><span class="s2">&quot;medianas&quot;</span><span class="o">]=</span><span class="s2">&quot;300&quot;</span> <span class="o">[</span><span class="s2">&quot;pequenas&quot;</span><span class="o">]=</span><span class="s2">&quot;160&quot;</span> <span class="o">[</span><span class="s2">&quot;miniaturas&quot;</span><span class="o">]=</span><span class="s2">&quot;70&quot;</span><span class="o">)</span>
<a name="cl-3"></a>
<a name="cl-4"></a><span class="c"># Hacemos las comprobaciones necesarias sobre el primer argumento</span>
<a name="cl-5"></a><span class="k">if</span> <span class="o">[</span> ! <span class="s2">&quot;$1&quot;</span> <span class="o">]</span>;
<a name="cl-6"></a><span class="k">then</span>
<a name="cl-7"></a><span class="k">        </span><span class="nb">echo</span> <span class="s1">&#39;Teneis que especificar al menos un argumento&#39;</span>
<a name="cl-8"></a>        <span class="nb">exit </span>0
<a name="cl-9"></a><span class="k">elif</span> <span class="o">[</span> ! -f <span class="s2">&quot;$1&quot;</span> <span class="o">]</span>;
<a name="cl-10"></a><span class="k">then</span>
<a name="cl-11"></a><span class="k">        </span><span class="nb">echo</span> <span class="s1">&#39;El archivo&#39;</span> <span class="s2">&quot;$1&quot;</span> <span class="s1">&#39;no existe&#39;</span>
<a name="cl-12"></a>        <span class="nb">exit </span>0
<a name="cl-13"></a><span class="k">fi</span>
<a name="cl-14"></a>
<a name="cl-15"></a><span class="c"># Llamamos a sha1sum para que calcule el hash SHA-1 sobre el archivo encomendado</span>
<a name="cl-16"></a><span class="nv">HASH</span><span class="o">=</span><span class="sb">`</span>sha1sum <span class="s2">&quot;$1&quot;</span><span class="sb">`</span>
<a name="cl-17"></a><span class="nb">declare</span> -a ARREGLO
<a name="cl-18"></a>
<a name="cl-19"></a><span class="nv">i</span><span class="o">=</span>0
<a name="cl-20"></a><span class="k">for </span>x in <span class="nv">$HASH</span>
<a name="cl-21"></a><span class="k">do</span>
<a name="cl-22"></a><span class="k">        </span>ARREGLO<span class="o">[</span><span class="nv">$i</span><span class="o">]=</span><span class="nv">$x</span>
<a name="cl-23"></a>        <span class="o">((</span>i++<span class="o">))</span>
<a name="cl-24"></a><span class="k">done</span>
<a name="cl-25"></a>
<a name="cl-26"></a>
<a name="cl-27"></a><span class="nv">dir1</span><span class="o">=</span><span class="k">${</span><span class="nv">ARREGLO</span><span class="p">[0]:</span><span class="nv">0</span><span class="p">:</span><span class="nv">2</span><span class="k">}</span>
<a name="cl-28"></a><span class="nv">dir2</span><span class="o">=</span><span class="k">${</span><span class="nv">ARREGLO</span><span class="p">[0]:</span><span class="nv">2</span><span class="p">:</span><span class="nv">2</span><span class="k">}</span>
<a name="cl-29"></a><span class="nv">archivo</span><span class="o">=</span><span class="k">${</span><span class="nv">ARREGLO</span><span class="p">[0]:</span><span class="nv">4</span><span class="k">}</span>
<a name="cl-30"></a><span class="nv">indice_punto</span><span class="o">=</span><span class="k">$(</span> expr index <span class="s2">&quot;${ARREGLO[1]}&quot;</span> . <span class="k">)</span>
<a name="cl-31"></a><span class="nv">extension</span><span class="o">=</span><span class="k">$(</span> <span class="nb">echo</span> <span class="k">${</span><span class="nv">ARREGLO</span><span class="p">[1]:</span><span class="nv">$indice_punto</span><span class="k">}</span> | tr <span class="s1">&#39;[A-Z]&#39;</span> <span class="s1">&#39;[a-z]&#39;</span><span class="k">)</span>
<a name="cl-32"></a>
<a name="cl-33"></a><span class="nb">echo</span> <span class="s2">&quot;arreglo[0] = &quot;</span> <span class="k">${</span><span class="nv">ARREGLO</span><span class="p">[0]</span><span class="k">}</span>
<a name="cl-34"></a><span class="nb">echo</span> <span class="s2">&quot;arreglo[1] = &quot;</span> <span class="k">${</span><span class="nv">ARREGLO</span><span class="p">[1]</span><span class="k">}</span>
<a name="cl-35"></a><span class="nb">echo</span> <span class="s2">&quot;dir1 = &quot;</span> <span class="nv">$dir1</span>
<a name="cl-36"></a><span class="nb">echo</span> <span class="s2">&quot;dir2 = &quot;</span> <span class="nv">$dir2</span>
<a name="cl-37"></a><span class="nb">echo</span> <span class="s2">&quot;archivo = &quot;</span> <span class="nv">$archivo</span>
<a name="cl-38"></a><span class="nb">echo</span> <span class="s2">&quot;extension = &quot;</span> <span class="nv">$extension</span>
<a name="cl-39"></a>
<a name="cl-40"></a><span class="c"># Comprobamos que el directorio de salida existe</span>
<a name="cl-41"></a><span class="k">if</span> <span class="o">[</span> ! <span class="s2">&quot;$2&quot;</span> <span class="o">]</span>;
<a name="cl-42"></a><span class="k">then</span>
<a name="cl-43"></a><span class="k">        </span><span class="nb">echo</span> <span class="s1">&#39;No especificaste el directorio de salida&#39;</span>
<a name="cl-44"></a>        <span class="nv">base</span><span class="o">=</span>.
<a name="cl-45"></a><span class="k">elif</span> <span class="o">[</span> ! -d <span class="s2">&quot;$2&quot;</span> <span class="o">]</span>;
<a name="cl-46"></a><span class="k">then</span>
<a name="cl-47"></a><span class="k">        </span><span class="nb">echo</span> <span class="s1">&#39;El directorio de salida no existe&#39;</span>
<a name="cl-48"></a>        <span class="nv">base</span><span class="o">=</span>.
<a name="cl-49"></a><span class="k">else</span>
<a name="cl-50"></a><span class="k">        </span><span class="nv">base</span><span class="o">=</span><span class="s2">&quot;$2&quot;</span>
<a name="cl-51"></a><span class="k">fi</span>
<a name="cl-52"></a>
<a name="cl-53"></a><span class="k">for </span>i in <span class="s2">&quot;${!TAMANOS[@]}&quot;</span>
<a name="cl-54"></a><span class="k">do</span>
<a name="cl-55"></a>        <span class="c"># Chequeamos que el primer directorio exista</span>
<a name="cl-56"></a>        <span class="k">if</span> <span class="o">[</span> ! -d <span class="s2">&quot;$base&quot;</span>/<span class="s2">&quot;$i&quot;</span> <span class="o">]</span>;
<a name="cl-57"></a>        <span class="k">then</span>
<a name="cl-58"></a><span class="k">                </span>mkdir <span class="s2">&quot;$base&quot;</span>/<span class="s2">&quot;$i&quot;</span>
<a name="cl-59"></a>        <span class="k">fi</span>
<a name="cl-60"></a>
<a name="cl-61"></a>        <span class="c"># Chequeamos que el segundo directorio exista</span>
<a name="cl-62"></a>        <span class="k">if</span> <span class="o">[</span> ! -d <span class="s2">&quot;$base&quot;</span>/<span class="s2">&quot;$i&quot;</span>/<span class="s2">&quot;$dir1&quot;</span> <span class="o">]</span>;
<a name="cl-63"></a>        <span class="k">then</span>
<a name="cl-64"></a><span class="k">                </span>mkdir <span class="s2">&quot;$base&quot;</span>/<span class="s2">&quot;$i&quot;</span>/<span class="s2">&quot;$dir1&quot;</span>
<a name="cl-65"></a>        <span class="k">fi</span>
<a name="cl-66"></a>
<a name="cl-67"></a>        <span class="c"># Chequeamos que el tercer directorio exista</span>
<a name="cl-68"></a>        <span class="k">if</span> <span class="o">[</span> ! -d <span class="s2">&quot;$base&quot;</span>/<span class="s2">&quot;$i&quot;</span>/<span class="s2">&quot;$dir1&quot;</span>/<span class="s2">&quot;$dir2&quot;</span> <span class="o">]</span>;
<a name="cl-69"></a>        <span class="k">then</span>
<a name="cl-70"></a><span class="k">                </span>mkdir <span class="s2">&quot;$base&quot;</span>/<span class="s2">&quot;$i&quot;</span>/<span class="s2">&quot;$dir1&quot;</span>/<span class="s2">&quot;$dir2&quot;</span>
<a name="cl-71"></a>        <span class="k">fi</span>
<a name="cl-72"></a>
<a name="cl-73"></a><span class="k">        </span><span class="nv">ancho</span><span class="o">=</span><span class="sb">`</span>identify -format <span class="s1">&#39;%w&#39;</span> <span class="s2">&quot;$1&quot;</span><span class="sb">`</span>
<a name="cl-74"></a>        <span class="nv">alto</span><span class="o">=</span><span class="sb">`</span>identify -format <span class="s1">&#39;%h&#39;</span> <span class="s2">&quot;$1&quot;</span><span class="sb">`</span>
<a name="cl-75"></a>        <span class="nv">ruta_archivo</span><span class="o">=</span><span class="s2">&quot;$base&quot;</span>/<span class="s2">&quot;$i&quot;</span>/<span class="s2">&quot;$dir1&quot;</span>/<span class="s2">&quot;$dir2&quot;</span>/<span class="s2">&quot;$archivo&quot;</span>.<span class="s2">&quot;$extension&quot;</span>
<a name="cl-76"></a>
<a name="cl-77"></a>        <span class="k">if</span> <span class="o">[</span> <span class="s2">&quot;$i&quot;</span> <span class="o">=</span> <span class="s1">&#39;pequenas&#39;</span> -o <span class="s2">&quot;$i&quot;</span> <span class="o">=</span> <span class="s1">&#39;miniaturas&#39;</span> <span class="o">]</span>;
<a name="cl-78"></a>        <span class="k">then</span>
<a name="cl-79"></a><span class="k">                if</span> <span class="o">[</span> <span class="nv">$ancho</span> -gt <span class="nv">$alto</span> <span class="o">]</span>;
<a name="cl-80"></a>                <span class="k">then</span>
<a name="cl-81"></a><span class="k">                        </span>convert <span class="s2">&quot;$1&quot;</span> -resize x<span class="s2">&quot;${TAMANOS[$i]}&quot;</span> <span class="s2">&quot;$ruta_archivo&quot;</span>
<a name="cl-82"></a>                        <span class="nv">ancho</span><span class="o">=</span><span class="sb">`</span>identify -format <span class="s1">&#39;%w&#39;</span> <span class="s2">&quot;$ruta_archivo&quot;</span><span class="sb">`</span>
<a name="cl-83"></a>                        <span class="nv">alto</span><span class="o">=</span><span class="sb">`</span>identify -format <span class="s1">&#39;%h&#39;</span> <span class="s2">&quot;$ruta_archivo&quot;</span><span class="sb">`</span>
<a name="cl-84"></a>                        <span class="nv">marco</span><span class="o">=</span><span class="k">$(</span> <span class="nb">echo</span> <span class="s2">&quot;($ancho - $alto) / 2&quot;</span> | bc <span class="k">)</span>
<a name="cl-85"></a>                        convert <span class="s2">&quot;$ruta_archivo&quot;</span> -shave <span class="s2">&quot;$marco&quot;</span>x0 <span class="s2">&quot;$ruta_archivo&quot;</span>
<a name="cl-86"></a>                <span class="k">elif</span> <span class="o">[</span> <span class="nv">$alto</span> -gt <span class="nv">$ancho</span> <span class="o">]</span>;
<a name="cl-87"></a>                <span class="k">then</span>
<a name="cl-88"></a><span class="k">                        </span>convert <span class="s2">&quot;$1&quot;</span> -resize <span class="s2">&quot;${TAMANOS[$i]}&quot;</span> <span class="s2">&quot;$ruta_archivo&quot;</span>
<a name="cl-89"></a>                        <span class="nv">ancho</span><span class="o">=</span><span class="sb">`</span>identify -format <span class="s1">&#39;%w&#39;</span> <span class="nv">$ruta_archivo</span><span class="sb">`</span>
<a name="cl-90"></a>                        <span class="nv">alto</span><span class="o">=</span><span class="sb">`</span>identify -format <span class="s1">&#39;%h&#39;</span> <span class="nv">$ruta_archivo</span><span class="sb">`</span>
<a name="cl-91"></a>                        <span class="nv">marco</span><span class="o">=</span><span class="k">$(</span> <span class="nb">echo</span> <span class="s2">&quot;($alto - $ancho) / 2&quot;</span> | bc <span class="k">)</span>
<a name="cl-92"></a>                        convert <span class="s2">&quot;$ruta_archivo&quot;</span> -shave 0x<span class="s2">&quot;$marco&quot;</span> <span class="s2">&quot;$ruta_archivo&quot;</span>
<a name="cl-93"></a>                <span class="k">fi</span>
<a name="cl-94"></a><span class="k">        else</span>
<a name="cl-95"></a><span class="k">                </span>convert -resize <span class="s2">&quot;${TAMANOS[$i]}&quot;</span> <span class="s2">&quot;$1&quot;</span> <span class="s2">&quot;$ruta_archivo&quot;</span>
<a name="cl-96"></a>        <span class="k">fi</span>
<a name="cl-97"></a>
<a name="cl-98"></a>        <span class="c"># Convertimos la imagen a los tamanos especificados en TAMANOS</span>
<a name="cl-99"></a>        <span class="nb">echo</span> <span class="s1">&#39;El archivo&#39;</span> <span class="s2">&quot;$1&quot;</span> <span class="s1">&#39;fue copiado a la ubicacion: &#39;</span> <span class="s2">&quot;$ruta_archivo&quot;</span>
<a name="cl-100"></a><span class="k">done</span>
<a name="cl-101"></a>
<a name="cl-102"></a><span class="nb">exit </span>1
</pre></div>
</td></tr></table>
    </div>
  
  </div>
  


  <div id="mask"><div></div></div>

  </div>

      </div>
    </div>

  </div>

  <div id="footer">
    <ul id="footer-nav">
      <li>Copyright © 2012 <a href="http://atlassian.com">Atlassian</a></li>
      <li><a href="http://www.atlassian.com/hosted/terms.jsp">Terms of Service</a></li>
      <li><a href="http://www.atlassian.com/about/privacy.jsp">Privacy</a></li>
      <li><a href="//bitbucket.org/site/master/issues/new">Report a Bug to Bitbucket</a></li>
      <li><a href="http://confluence.atlassian.com/x/IYBGDQ">API</a></li>
      <li><a href="http://status.bitbucket.org/">Server Status</a></li>
    </ul>
    <ul id="social-nav">
      <li class="blog"><a href="http://blog.bitbucket.org">Bitbucket Blog</a></li>
      <li class="twitter"><a href="http://www.twitter.com/bitbucket">Twitter</a></li>
    </ul>
    <h5>We run</h5>
    <ul id="technologies">
      <li><a href="http://www.djangoproject.com/">Django 1.3.1</a></li>
      <li><a href="//bitbucket.org/jespern/django-piston/">Piston 0.3dev</a></li>
      <li><a href="http://git-scm.com/">Git 1.7.6</a></li>
      <li><a href="http://www.selenic.com/mercurial/">Hg 2.2.1</a></li>
      <li><a href="http://www.python.org">Python 2.7.3</a></li>
      <li>f9292b79c35c | bitbucket12</li>
    </ul>
  </div>

  <script src="https://dwz7u9t8u8usb.cloudfront.net/m/1a1b57f0564b/js/lib/global.js"></script>






  <script>
    BB.gaqPush(['_trackPageview']);
  
    BB.gaqPush(['atl._trackPageview']);

    

    

    (function () {
        var ga = document.createElement('script');
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        ga.setAttribute('async', 'true');
        document.documentElement.firstChild.appendChild(ga);
    }());
  </script>

</body>
</html>
