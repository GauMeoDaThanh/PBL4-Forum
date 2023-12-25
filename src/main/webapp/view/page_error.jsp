<html>
<head>
    <title>404 Page Not Found</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <style>
        .page_404{
            padding:40px 0;
            background:#fff;
            font-family: 'Arvo', serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;

        }

        .page_404  img{ width:100%;}

        .four_zero_four_bg{

            background-image: url(https://cdn.dribbble.com/users/285475/screenshots/2083086/dribbble_1.gif);
            height: 600px;
            background-position: center;
        }


        .four_zero_four_bg h1{
            font-size:80px;
        }

        .four_zero_four_bg h3{
            font-size:80px;
        }

        .sub-content {
            font-size: 20px;
        }

        .link_404{
            color: #fff!important;
            padding: 10px 20px;
            background: #39ac31;
            margin: 20px 0;
            display: inline-block;}
        .contant_box_404{ margin-top:-50px;}
    </style>
</head>
<body>
<section class="page_404">
    <div class="container">
        <div class="row">
            <div class="col-sm-12 ">
                <div class="text-center">
                    <div class="four_zero_four_bg">
                        <h1 class="text-center ">Oops!</h1>
                    </div>

                    <div class="contant_box_404">
                        <h3 class="h2">
                            Page not found
                        </h3>

                        <p class="sub-content">Current page not found!</p>

                        <!-- <a href="" class="link_404">Go to Home</a> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
