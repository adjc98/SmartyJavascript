{literal}
<script> 
$(document).ready(function() {

 $('#address_book_B_state').attr( 'onchange', 'javascript:openFB();' );
 $('#b_state').attr( 'onchange', 'javascript:openFB();' );

    
    });



//Get https url base
 {/literal}{if isset($test_states)}{literal}
var currenturl= "{/literal}{$catalogs_secure.customer}{literal}";
{/literal}{/if}{literal}

removeundeliverables = function()
                {



                    //build url call string for each product that needs to be removed
    var cartid_string="";
    Object.keys(removearr).forEach(function (key) 
    { 


    cartid_string=cartid_string + "&productindex[]=" + removearr[key];  
   
    });

hereoneto= currenturl +'/cart.php?mode=deleterestricted' + cartid_string;

 console.log(hereoneto);
                    var xmlHttp;
                        if (window.XMLHttpRequest)
                            {// code for IE7+, Firefox, Chrome, Opera, Safari
                                xmlHttp=new XMLHttpRequest();
                            }
                        else
                            {// code for IE6, IE5
                                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                            }
                    xmlHttp.onreadystatechange=function()
                            {
                                if (xmlHttp.readyState==4 && xmlHttp.status==200)
                            {
                               //alert('your cart yeah!');
                            

                            }
                            else 
                            {

                                    $( "#restrictionWait" ).show();
                                    //give fancybox some time to close
                                    setTimeout(function() 
                                    {
                                    $.fancybox.close();
                                     location.reload();
                                    }, 1000);
                                 
                           /*      // Rebuild the cart totals and shipping //
                            if (checkoutIsShippingLoaded(null))
                            checkoutLoadShipping(true);
                            else
                            checkoutRebuildCartTotals(null); */

                            }

                            }

                    // Make a post request to the server //
                    xmlHttp.open('POST', '' + currenturl +'/cart.php?mode=deleterestricted' + cartid_string +'', true);
                    xmlHttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    
                    // Make the server request //
                    xmlHttp.send();
}


var arr = new Array();


{/literal}{if isset($test_states)}{literal}
var testarr= {/literal}{$test_states}{literal};
{/literal}{/if}{literal}

{/literal}{if isset($test_products)}{literal}
var productsarr= {/literal}{$test_products}{literal};
{/literal}{/if}{literal}



if (typeof testarr !== 'undefined')   


{
    // the variable is defined



openFB = function () {

    $( "#restrictionWait" ).hide();
var selected_state_text=$( "#b_state option:selected" ).text(); 
var selected_state=$( "#b_state option:selected" ).val();
//create array of products that are undeliverable
var statearr= new Array();
removearr= new Array();
    for (i = 0; i < testarr.length; i++) 
    {
        var statecount=0;
        for (x = 0; x < testarr[i].length; x++) 
        {
            
         if(testarr[i][x].state_val==selected_state)
            statecount=statecount+1;
                
         } 
         if(statecount==0){
           statearr[i]=productsarr[i].product;
           removearr[i]=productsarr[i].cartid;
        }
    }

    //if there are undeliverables show fancybox
    if(typeof statearr !== 'undefined' && statearr.length > 0)
                    {
                        $.fancybox({
                        'href'   : '#myDivID',
                        'titleShow'  : false,
                        'transitionIn'  : 'elastic',
                        'transitionOut' : 'elastic'
                                    });
                   }

      //build undeliverable list of products in string
      var product_string="";  
      var count_prod="";
 Object.keys(statearr).forEach(function (key) { 


    product_string=product_string + "<div>" + statearr[key] + "<div>";  

count_prod=count_prod+1;

});
 //plural singular logic
var prod_s="";
var prod_are="is";
var prod_the="the";
if( count_prod>1)
{
prod_s="s";
prod_are="are";
prod_the="these";
}

//build fancybox content
$( "#myDivID > span:nth-child(1)" ).replaceWith('<span><div style="font-size:larger; text-align: center;">Do to agricultural law, we cannot ship ' + prod_the + ' following product'+ prod_s +' to <strong>' +  selected_state_text +'</strong> </div><div style="FONT-SIZE: 24px !important; font-size:larger; text-align: center; COLOR: #006837; padding-top:15px;">' + product_string + '</div></span>');
 }
 }   
</script>
{/literal} 




<div style="display:none">
    <div id="myDivID" style="text-align:center;">
         <span > The is a test hello what is up necessary line keep don't delete ok please leave me here yea yea
            </span>
         <span><a style="padding-top:15px;" onclick="javascript:removeundeliverables();"> <img style="padding-top: 15px;cursor: pointer;" src="skin/common_files/images/remove_button.png"></a></span>
         <div><a onclick="$.fancybox.close();"> <img style="padding-top: 15px;cursor: pointer;" src="skin/common_files/images/gift_ship_button.png"></a></div>
         <div id="restrictionWait" style="display:none;">
<p><img src="/skin/common_files/images/white_wait.gif" alt="" height="16" width="16"></p>
<p>Removing the restricted products from your cart...</p>
</div>
<br>
    </div>
</div>
{*end ryan code 1/13/15*}
