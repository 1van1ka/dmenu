static int topbar                        = 1;     /* -b  option; if 0, dmenu appears at bottom     */
static int centered                      = 0;     /* -c option; centers dmenu on screen */
static unsigned int min_width            = 600;   /* -mw option; minimum width when centered */
static int height_separator              = 3;     /* heigth separator between the input line and the hints */
static unsigned int lines                = 0;     /* -l option; default count lines in box hints */
static unsigned int lineheight           = 35;    /* -lh option; default height line*/
static const float height_ratio          = 0.25;  /* This is the ratio used in the original calculation */
static const char worddelimiters[]       = " ";   /* for example: " /?\"&[]" */
static const char *fonts[] = {
	"JetBrains Mono:size=14:style=Bold",
};

static char normfgcolor[]                = "#fff8e6";
static char normbgcolor[]                = "#282828";
static char selfgcolor[]                 = "#fff8e6";
static char selbgcolor[]                 = "#8f0000";
static char sepfgcolor[]                 = "#5e5e5e";
static char sepbgcolor[]                 = "#5e5e5e";
static char outfgcolor[]                 = "#000000";
static char outbgcolor[]                 = "#00ffff";

static const unsigned int bgalpha        = 0xe0;
static const unsigned int fgalpha        = OPAQUE;
static const char *prompt                = NULL;


static const char *colors[SchemeLast][2] = {\
	[SchemeSep]  = { sepfgcolor, sepbgcolor },
	[SchemeNorm] = { normfgcolor, normbgcolor },
	[SchemeSel]  = { selfgcolor, selbgcolor },
	[SchemeOut]  = { outfgcolor, outbgcolor },
};

static const unsigned int alphas[SchemeLast][2] = {
	[SchemeSep] = { fgalpha, bgalpha },
	[SchemeNorm] = { fgalpha, bgalpha },
	[SchemeSel] = { fgalpha, bgalpha },
	[SchemeOut] = { fgalpha, bgalpha },
};
