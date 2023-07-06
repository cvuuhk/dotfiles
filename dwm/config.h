// appearance
static const unsigned int borderpx  = 2;    // border pixel of windows
static const unsigned int gappx     = 5;    // gaps between windows
static const unsigned int snap      = 8;    // snap pixel
static const int showbar            = 1;    // 0 means no bar
static const int topbar             = 1;    // 0 means bottom bar
static const char *fonts[]          = { "CaskaydiaCove Nerd Font Mono:size=12", "PingFang SC:size=12" };
static const char dmenufont[]       = "monospace:size=10";
// Everforest
// static const char normbgcolor[] = "#2f383e";
// static const char normbordercolor[] = "#868d80";
// static const char normfgcolor[] = "#d8caac";
// static const char selfgcolor[] = "#2f383e";
// static const char selbgcolor[] = "#a7c080";
// static const char selbordercolor[] = "#a7c080";

// Gruvbox
static const char normfgcolor[]     = "#d4be98";
static const char normbgcolor[]     = "#282828";
static const char normbordercolor[] = "#282828";
static const char selfgcolor[]      = "#282828";
static const char selbgcolor[]      = "#a9b665";
static const char selbordercolor[]  = "#d4be98";
static const char *colors[][3] = {
  //               fg           bg           border
  [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor} ,
  [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor}  ,
};

// tagging
static const char *tags[] = {"自", "己", "动", "手", "😋", "丰", "衣", "足", "食"};

static const Rule rules[] = {
  // xprop(1):
  // WM_CLASS(STRING) = instance, class
  // WM_NAME(STRING) = title
  // class                  instance    title   tags mask   isfloating   monitor
  { "flameshot",            NULL,       NULL,   0,          1,           -1},
  { "SimpleScreenRecorder", NULL,       NULL,   0,          1,           -1},
};

// layouts
static const float mfact     = 0.55; // factor of master area size [0.05..0.95]
static const int nmaster     = 1;    // number of clients in master area
static const int resizehints = 0;    // 1 means respect size hints in tiled resizals
static const int lockfullscreen = 1; // 1 will force focus on the fullscreen window

static const Layout layouts[] = {
  // symbol  arrange function
  { "[铺]",  tile }, // first entry is default
  { "[浮]",  NULL }, // no layout function means floating behavior
  { "[单]",  monocle },
};

// key definitions
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
  { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
  { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

// helper for spawning shell commands in the pre dwm-5.0 fashion
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

// commands
static const char *dmenucmd[] = { "rofi", "-show", "drun", "-show-icons", NULL };
static const char *termcmd[]  = { "alacritty", NULL };

#include <X11/XF86keysym.h>
static const Key keys[] = {
  // modifier                     key        function        argument
  { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
  { MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
  { MODKEY,                       XK_b,      togglebar,      {0} },
  { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
  { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
  { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
  { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
  { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
  { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
  { MODKEY,                       XK_q,      killclient,     {0} },
  { MODKEY|ShiftMask,             XK_q,      quit,           {0} },
  { MODKEY,                       XK_comma,  zoom,           {0} },
  { MODKEY,                       XK_Tab,    view,           {0} },
  { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
  { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
  { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
  // { MODKEY,                       XK_space,  setlayout,      {0} },
  { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
  { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
  { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
  // { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
  // { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
  // { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
  // { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
  TAGKEYS(                        XK_1,                      0)
  TAGKEYS(                        XK_2,                      1)
  TAGKEYS(                        XK_3,                      2)
  TAGKEYS(                        XK_4,                      3)
  TAGKEYS(                        XK_5,                      4)
  TAGKEYS(                        XK_6,                      5)
  TAGKEYS(                        XK_7,                      6)
  TAGKEYS(                        XK_8,                      7)
  TAGKEYS(                        XK_9,                      8)
  { MODKEY,                       XK_space,  spawn,          SHCMD("firefox")},
  { 0,                            XK_Print,  spawn,          SHCMD("flameshot gui")},

  { 0,             XF86XK_AudioMute,         spawn,          SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle && bash ~/.dotfiles/dwm/bar.sh")},
  { 0,             XF86XK_AudioRaiseVolume,  spawn,          SHCMD("pactl set-sink-volume @DEFAULT_SINK@ +5% && bash ~/.dotfiles/dwm/bar.sh")},
  { 0,             XF86XK_AudioLowerVolume,  spawn,          SHCMD("pactl set-sink-volume @DEFAULT_SINK@ -5% && bash ~/.dotfiles/dwm/bar.sh")},
  // { 0,             XF86XK_AudioMute,         spawn,          SHCMD("amixer -q sset Master 0   && bash ~/.dotfiles/dwm/bar.sh")},
  // { 0,             XF86XK_AudioRaiseVolume,  spawn,          SHCMD("amixer -q sset Master 3%+ && bash ~/.dotfiles/dwm/bar.sh")},
  // { 0,             XF86XK_AudioLowerVolume,  spawn,          SHCMD("amixer -q sset Master 3%- && bash ~/.dotfiles/dwm/bar.sh")},
  { 0,             XF86XK_MonBrightnessUp,   spawn,          SHCMD("light -A 3%")},
  { 0,             XF86XK_MonBrightnessDown, spawn,          SHCMD("light -U 3%")},
};

// button definitions
// click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin
static const Button buttons[] = {
  // click                event mask      button          function        argument
  { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
  { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
  { ClkWinTitle,          0,              Button2,        zoom,           {0} },
  { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
  { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
  { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
  { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
  { ClkTagBar,            0,              Button1,        view,           {0} },
  { ClkTagBar,            0,              Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
  { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

