#' @title Carbon R6 class
#' @description The Carbon generator creates a new `Carbon`-object, which is the class containing
#' all the app logic. The class is based on the [R6][R6::R6Class] OO-system and
#' is thus reference-based with methods and data attached to each object, in
#' contrast to the more well known S3 and S4 systems.
#' @format NULL
#' @usage NULL
#' @section Initialization:
#' A new 'Carbon'-object is initialized using the `new()` method on the generator:
#' 
#' \tabular{l}{
#'  `x <- carbon$new(code = clipr::read_clip())`
#' }
#' 
#' 
#' @section Fields:
#' 
#' \if{html}{
#' \out{
#' <br>
#' <details>
#' <summary> <span title='Click to Expand'> <big> Public Fields </big> </span> </summary>
#' }
#' }
#' 
#' Description of fields of the R6 object that can be set by the user can be found
#'  in the following [page][carbonate::carbon-fields].
#'
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#'
#' @section Methods:
#'
#' \if{html}{
#' \out{
#' <br>
#' <details>
#' <summary> <span title='Click to Expand'> <big> Interacting with Browser </big> </span> </summary>
#' }
#' }
#' 
#' \tabular{ll}{
#' [$carbonate][carbonate::carbon-carbonate] \tab Using RSelenium fetch the carbon image output \cr
#' [$browse][carbonate::.browse] \tab open [$uri][carbonate::carbon-uri] in the browser \cr
#' }
#'
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#'
#'
#' \if{html}{
#' \out{
#' <br>
#' <details>
#' <summary> <span title='Click to Expand'> <big> Aesthetics </big> </span> </summary>
#' }
#' }
#' \tabular{ll}{
#' [$set_template][carbonate::carbon-set-fields] \tab set $template \cr
#' [$get_templates][carbonate::carbon-get-fields] \tab get a list of possible templates \cr
#' [$set_window_control_theme][carbonate::carbon-set-fields] \tab  set $windows_control_theme \cr
#' [$get_windows_control_themes][carbonate::carbon-get-fields] \tab get a list of possible window control themes\cr
#' [$set_font_family][carbonate::carbon-set-fields] \tab set $font_family\cr
#' [$get_font_families][carbonate::carbon-get-fields] \tab get a list of possible fonts \cr
#' }
#' 
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#'
#' \if{html}{
#' \out{
#' <br>
#' <details>
#' <summary> <span title='Click to Expand'> <big> URI Building </big> </span> </summary>
#' }
#' }
#' \tabular{ll}{
#' [$uri][carbonate::carbon-uri] \tab construct valid carbon.js uri \cr
#' [$options][carbonate::carbon-options] \tab return all current carbon options\cr
#' [$encode][carbonate::carbon-encode] \tab URL encode a string for the $uri  \cr
#' }
#' 
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#'
#' \if{html}{
#' \out{
#' <br>
#' <details>
#' <summary> <span title='Click to Expand'> <big> Webdriver Settings </big> </span> </summary>
#' }
#' }
#' \tabular{ll}{
#' [$chromeOptions][carbonate::carbon-chrome] \tab construct a chromeOptions object \cr
#' [$chrome_start][carbonate::carbon-chrome] \tab start a chrome session \cr
#' [$chrome_stop][carbonate::carbon-chrome] \tab stop a chrome session \cr
#' [$start][carbonate::carbon-selenium] \tab start a RSelenium session \cr
#' [$stop][carbonate::carbon-selenium] \tab stop a RSelenium session \cr
#' [$stop_all][carbonate::carbon-selenium] \tab stop all active RSelenium sessions \cr
#' }
#' 
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#' 
#' 
#' @rdname carbon
#' @export
#' @importFrom R6 R6Class
#' @importFrom clipr read_clip
carbon <- R6::R6Class(classname = 'Carbon',
                      public = list(
                        initialize = function(code = clipr::read_clip()){
                          self$code = code
                        },
                        code                         = NULL,
                        palette                      = c(r=171,g=184,b=195,a=1),
                        template                     = 'seti',
                        window_control_theme         = 'none',
                        language                     = 'r', 
                        add_drop_shadow              = TRUE, 
                        drop_shadow_offset_y         = 20, 
                        drop_shadow_blur_radius      = 68, 
                        add_window_control           = TRUE, 
                        auto_adjust_width            = TRUE, 
                        padding_vertical             = 48,
                        padding_horizontal           = 32,
                        add_line_number              = FALSE, 
                        font_family                  = 'Hack',
                        font_size                    = 14, 
                        line_height_percent          = 133,
                        square_image                 = FALSE, 
                        relative_export_size         = 1,
                        add_watermark                = FALSE,
                        carbons = list(),
                        chrome_args                  = c('--disable-gpu', '--window-size=1280,800'),
                        chrome_pref                   = list(
                          "profile.default_content_settings.popups" = 0L,
                          "download.prompt_for_download" = FALSE,
                          "download.default_directory" = tempdir()
                        ),
                        rD = NULL,
                        cDrv = NULL,
                        set_template = function(template = self$get_templates()[16]){
                          .set_template(self,private,template)
                        },
                        set_window_control_theme = function(theme = self$get_windows_control_themes()[1]){
                          .set_window_control_theme(self,private,theme)
                        },
                        set_font_family = function(family = self$get_font_families()[6]){
                          .set_font_family(self,private,family)
                        },
                        get_windows_control_themes = function(){
                          .get_windows_control_themes(self,private)
                          },
                        get_font_families = function(){
                          .get_font_families(self,private)
                        },
                        get_templates = function(){
                          .get_templates(self,private)
                        },
                        options = function(code = self$code){
                          .options(self,private,code)
                        },
                        uri = function(code = self$code){
                          .uri(self,private,code)
                        },
                        browse = function(){
                          .browse(self,private)
                        },
                        chromeOptions = function(){
                          .chromeOptions(self,private)
                        },
                        chrome_start = function(){
                          .chrome_start(self,private)
                        },
                        chrome_stop = function(){
                          .chrome_stop(self,private)
                        },
                        start = function(eCap = self$chromeOptions()) {
                          .start(self,private,eCap)
                        },
                        stop = function(){
                          .stop(self,private)
                        },
                        stop_all = function(){
                          .stop_all(self,private)
                        },
                        carbonate = function(file = 'carbon.png',code = self$code,rD = self$rD){

                         .carbonate(self,private,file,code,rD)
                          
                        },
                        encode = function(URL, reserved = FALSE, repeated = FALSE){
                         .encode(self,private,URL,reserved,repeated)
                        }
                      ),
                      private = list(
                        px_vars         = c('drop_shadow_offset_y',
                                            'drop_shadow_blur_radius',
                                            'padding_vertical',
                                            'padding_horizontal',
                                            'font_size'),
                        logical_vars    = c('add_drop_shadow',
                                            'add_window_control',
                                            'auto_adjust_width',
                                            'add_line_number',
                                            'square_image',
                                            'add_watermark'),
                        var_names = c( 
                          palette = 'bg',
                          template = 't',
                          window_control_theme = 'wt',
                          language  = 'l',
                          add_drop_shadow = 'ds',
                          drop_shadow_offset_y = 'dsyoff',
                          drop_shadow_blur_radius  = 'dsblur',
                          add_window_control = 'wc',
                          auto_adjust_width = 'wa',
                          padding_vertical = 'pv',
                          padding_horizontal = 'ph',
                          add_line_number = 'ln',
                          font_family = 'fm',
                          font_size = 'fs',
                          line_height_percent = 'lh',
                          square_image = 'si',
                          relative_export_size = 'es',
                          add_watermark = 'wm'
                        ),
                        rgba = function(x){
                          .rgba(self,private,x)
                        },
                        add_unit = function(x,unit = 'px'){
                          .add_unit(self,private,x,unit)
                        },
                        map_name  = function(name){
                          .map_name(self,private,name)
                        },
                        add_percent = function(value){
                          .add_percent(self,private,value)
                        },
                        convert_logical = function(value){
                          .convert_logical(self,private,value)
                        },
                        map = function(){
                          .map(self,private)
                        }
        )
        )