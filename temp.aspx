
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>Auto Complete</title>
</head>

<body>
    <h2 class="text-center">Auto Complete Textbox using javascript,php</h2>
    <div class="row mt-5 mb5">
        <div class="col col-sm-2">&nbsp;</div>
        <div class="col col-sm-8">
            <input type="text" name="Search" class="form-control form-control-lg" placeholder="Search user name here." onkeyup="javascript:loadData(this.value)">
            <span id="searchResult"></span>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>

</html>
<script>
    function loadData(query) {
        if (query.length > 2) {
            var form_data = new FormData();
            form_data.append('query', query);
            var ajax_request = new XMLHttpRequest();
            ajax_request.open('POST', 'database.php');
            ajax_request.send(form_data)

            ajax_request.onreadystatechange = function() {
                if (ajax_request.response == 4 || ajax_request.status == 200) {
                    var response = JSON.parse(ajax_request.responseText);
                    var html ='<div class="list-group" >';
                    if(response.length > 0){
                        for(var cnt = 0;cnt < response.length ; cnt++){
                            html+= '<a href="#" class="list-group-item list-group-item-action">' + response[cnt].firstName + '</a>';
                        }
                    }
                    else{
                        html+= '<a href="#" class="list-group-item list-group-item-action disabled"> No Record found </a> ';
                    }
                    html+= '</div>';

                    document.getElementById('searchResult').innerHTML = "html";
                }
            }
        } else {
            document.getElementById('searchResult').innerHTML = "";
        }
    }
</script>