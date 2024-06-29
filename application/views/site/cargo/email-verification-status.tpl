<!DOCTYPE html>
<html>

<head>
    <base href="{$base_url}">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$title}</title>
    <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:400,400i,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" />

</head>

<body class="p-0">
    <div class="verify-ui">
        <div class="brand_top container-fluid">
            <h3>{$title}</h3>
        </div>
        <div class="row m-0">
            <div class="col-md-12" style="display: flex;">
                <div class="card col-md-5">
                    {if $verify->status == 1}
                        <div class="card-div">
                            <span class="text-success"><i class="fa fa-check checkmark" aria-hidden="true"></i></span>
                        </div>
                        <h1 class="text-success">Success</h1>
                        <p class="text-success">{$success_message}</p>
                    {else}
                        <div class="card-div">
                            <span class="text-danger"><i class="fa fa-times-circle" aria-hidden="true"></i></span>
                        </div>
                        <h1 class="text-danger">Error</h1>
                        <p class="text-danger">{$error_message}</p>
                    {/if}
                </div>
            </div>
        </div>
    </div>
    <style>
        body {
            text-align: center;
            padding-top: 0px !important;
            background: #EBF0F5;
        }

        .container-fluid {
            background-color: #FFFFFF !important;
        }

        .verify-ui h1 {
            font-family: "Nunito Sans", "Helvetica Neue", sans-serif;
            font-weight: 900;
            font-size: 40px;
            margin-bottom: 10px;
        }

        .verify-ui p {
            font-family: "Nunito Sans", "Helvetica Neue", sans-serif;
            font-size: 20px;
            margin: 0;
        }

        .verify-ui  i {
            font-size: 100px;
            line-height: 200px;
            margin-left: 5px;
            line-height: 2 !important;
        }

        .verify-ui .card {
            background: white;
            padding: 60px;
            border-radius: 4px;
            box-shadow: 0 2px 3px #C8D0D8;
            margin: 0 auto;
            margin-top: 50px;
        }

        .verify-ui .card-div {
            border-radius: 200px;
            height: 200px;
            width: 200px;
            background: #F8FAF5;
            margin: 0 auto;
        }
    </style>
</body>

</html>