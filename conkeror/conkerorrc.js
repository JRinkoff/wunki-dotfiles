require("adblockplus.js");
require("clicks-in-new-buffer.js");
require("mode-line.js");

require("/home/wunki/src/wunki-dotfiles/conkeror/instapaper.js");

// use 'contrib' stuff
load_paths.unshift("chrome://conkeror-contrib/content/");

// my custom keys
define_key(text_keymap, 'C-w', 'cmd_deleteWordBackward');
define_key(default_global_keymap, 'C-x C-m', 'execute-extended-command');

// improve hint keys
hint_background_color = "transparent";
hint_digits = "aoeuhtns";

// monospace theme
theme_load("mono");

// don't require a whitelist to install extensions
session_pref("xpinstall.whitelist.required", false);

// firefox user agent
session_pref("general.useragent.compatMode.firefox", true);

// don't enable formfill
session_pref("browser.formfill.enable", false);

// default directory
cwd = make_file("/home/wunki/downloads");

// save my passwords
session_pref("signon.rememberSignons", true);
session_pref("signon.expireMasterPassword", false);
session_pref("signon.SignonFileName", "signons.txt");
Cc["@mozilla.org/login-manager;1"].getService(Ci.nsILoginManager);

// hint's color
register_user_stylesheet(
    "data:text/css," +
	escape (
	  "span.__conkeror_hint {" +
		" border: 1px solid #E97F02 !important;" +
    " border-radius: 3px !important;" +
		" color: #490A3D !important;" +
		" background-color: #F8CA00 !important;" +
    " opacity: 0.8 !important;" +
    " font-size: 13px !important;" +
    " padding: 0.1em 0.2em!important;" +  
    " font-family: \"Ubuntu\" !important;" +  
		"}"));

// teach me something whenever I start my browser
homepage = "about:blank";

// open clicks in buffers (tabs) in the background
clicks_in_new_buffer_target = OPEN_NEW_BUFFER_BACKGROUND; 
clicks_in_new_buffer_button = 1;

// auto completion in the minibuffer
minibuffer_auto_complete_default = true;
url_completion_use_history = true;
url_completion_use_bookmarks = true;

// don't select the URI with G
minibuffer_read_url_select_initial = false;

// open new urls in new buffer
url_remoting_fn = load_url_in_new_buffer;

// we'd like to see the # of buffers being loaded 
add_hook("mode_line_hook", mode_line_adder(loading_count_widget), true);

// who wants a clock?
remove_hook("mode_line_hook", mode_line_adder(clock_widget));

// searches
define_webjump("gs", "https://encrypted.google.com/?q=%s");
define_opensearch_webjump("dd", "duckduckgo.xml");
define_opensearch_webjump("wk", "wikipedia.xml");
define_webjump("gh", "http://github.com/search?q=%s&type=Everything");
define_webjump("cl", "http://clojuredocs.org/search?x=0&y=0&q=%s");
define_webjump("imdb", "http://imdb.com/find?q=%s");
define_webjump("yt", "http://www.youtube.com/results?search_query=%s&search=Search");
define_webjump("yc", "http://www.hnsearch.com/search#request/all&q=%s");

// reload conkerorrc with C-c r
interactive("reload-config", "reload conkerorrc",
       function(I) {
          load_rc();
          I.window.minibuffer.message("config reloaded");
       }
);
define_key(default_global_keymap, "C-c r", "reload-config");

// org-protocol
function org_capture (url, title, selection, window) {
    var cmd_str = 'emacsclient \"org-protocol:/capture:/w/'+url+'/'+title+'/'+selection+'\"';
    if (window != null) {
      window.minibuffer.message('Issuing ' + cmd_str);
    }
    shell_command_blind(cmd_str);
}

// capture to org-mode with C-c c
interactive("org-capture", "Clip url, title, and selection to capture via org-protocol",
          function (I) {
              org_capture(encodeURIComponent(I.buffer.display_uri_string),
                          encodeURIComponent(I.buffer.document.title),
                          encodeURIComponent(I.buffer.top_frame.getSelection()),
                          I.window);
          }
);
define_key(content_buffer_normal_keymap, "C-c c", "org-capture");

// clear history
function clear_history () {
    var history = Cc["@mozilla.org/browser/nav-history-service;1"]
        .getService(Ci.nsIBrowserHistory);
    history.removeAllPages();
};
interactive("clear-history", "Clear the history.", clear_history);
