<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta property="og:image" content="img/landing/logo12.png" />
	<meta name="description" content="Клуб Профессионалов - это платформа, объединяющая людей, с целью заработка денег через Интернет.">
	
    <title>Личный кабинет | Клуб Профессионалов</title>
	
	<link rel="shortcut icon" href="../../img/favicon.png" type="image/png">
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../font-awesome/css/font-awesome.css" rel="stylesheet">

    <!-- Toastr style -->
    <link href="../../css/plugins/toastr/toastr.min.css" rel="stylesheet">

    <link href="../../css/animate.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">



</head>

<body class="fixed-sidebar no-skin-config">

<div id="wrapper">

    <nav class="navbar-default navbar-static-side" role="navigation" style="position: fixed">
    <div class="sidebar-collapse">
        <ul class="nav metismenu" id="side-menu">
            <li class="nav-header">
                <div class="dropdown profile-element"> <span>
                            <img alt="image" class="img-circle" src="img/profile_small.jpg" />
                             </span>
                    <a data-toggle="dropdown" class="dropdown-toggle" href="/mail">
                            <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold">
                            <?php
                                include_once 'auth_check.php'; // проверяем авторизирован ли пользователь
                                    if($user) {
                                        $search_name = mysql_query("SELECT `name` FROM `users` WHERE `username` = '".$user['username']."'");
                                        $name = (mysql_num_rows($search_name) == 1) ? mysql_fetch_array($search_name) : 0;

                                        $search_surname = mysql_query("SELECT `surname` FROM `users` WHERE `username` = '".$user['username']."'");
                                        $surname = (mysql_num_rows($search_surname) == 1) ? mysql_fetch_array($search_surname) : 0;
                                        echo $name['name'], '&nbsp;', $surname['surname'];                                    
                                        } else {
                                        // выводим информацию для гостя
                                        header ('Location: login.html');
                                        exit();
                                        }
                            ?>
                            </strong>
                             </span>
							 <p>Логин:                         
                                <b><?php

                                include_once 'auth_check.php'; // проверяем авторизирован ли пользователь

                            echo $user['username'];
                            ?></b><br>
							Ваш id:                         
                                <b><?php

                                include_once 'auth_check.php'; // проверяем авторизирован ли пользователь

                            echo $user['user_id'];
                            ?></b></p>
                    </a>
                </div>
                <div class="logo-element">
                    КП
                </div>
            </li>
            <li>
                <a href="index.php"><i class="fa fa-th-large"></i> <span class="nav-label">Главная</span></a>
            </li>
            <li>
                <a href="profile.php"><i class="fa fa-diamond"></i> <span class="nav-label">Профиль</span></a>
            </li>
            <li>
                <a href="comanda.php"><i class="fa fa-users"></i> <span class="nav-label">Команда</span></a>
            </li>
            <!--
            <li class="active">
                <a href="mail/index.php"><i class="fa fa-envelope"></i> <span class="nav-label">Сообщения</span><span class="label label-warning pull-right">16</span></a>
            </li>
            -->
            <li>
                <a href="faq.php"><i class="fa fa-envelope"></i> <span class="nav-label">Сообщения</span><span class="label label-warning pull-right">0</span></a>
            </li>
			<li>
                <a href="money.php"><i class="fa fa-money"></i> <span class="nav-label">Быстрые деньги</span></a>
            </li>
            <li>
                <a href="faq.php"><i class="fa fa-bank"></i> <span class="nav-label">Бизнес</span><span class="fa arrow"></span></a>
                <ul class="nav nav-second-level collapse">
                    <li><a href="faq.php">Мои бизнесы</a></li>
                    <li><a href="faq.php">Выбор бизнеса</a></li>
                </ul>
            </li>
			<li>
                <a href="faq.php"><i class="fa fa-edit"></i> <span class="nav-label">Инструменты</span><span class="fa arrow"></span></a>
                <ul class="nav nav-second-level collapse">
                    <li><a href="faq.php">Мои инструменты</a></li>
                    <li><a href="faq.php">Выбор инструментов</a></li>
                </ul>
            </li>

            <li>
                <a href="faq.php"><i class="fa fa-line-chart"></i> <span class="nav-label">Финансы</span></a>
            </li>
            <li>
                <a href="faq.php"><i class="fa fa-bullhorn"></i> <span class="nav-label">Мероприятия</span></a>
            </li>
			<li>
                <a href="faq.php"><i class="fa fa-book"></i> <span class="nav-label">Вопрос / Ответ</span></a>
            </li>
            <li>
                <a href="faq.php"><i class="fa fa-edit"></i> <span class="nav-label">Другие сервисы</span><span class="fa arrow"></span></a>
			</li>
            <li>
                <a href="faq.php"><i class="fa fa-th"></i> <span class="nav-label">Сотрудничество</span></a>
            </li>
        </ul>

    </div>
</nav>


    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
<nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0;">
    <div class="navbar-header">
        <a class="navbar-minimalize minimalize-styl-2 btn btn-primary" href="#" title="Скрыть меню"><i class="fa fa-bars"></i> </a>
        <form role="search" class="navbar-form-custom" action="search_results.html">
            <div class="form-group">
                <input type="text" placeholder="Поиск" class="form-control" name="top-search" id="top-search">
            </div>
        </form>
    </div>
    <ul class="nav navbar-top-links navbar-right">
        <li class="dropdown">
            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="mail/index.php#">
                <i class="fa fa-envelope"></i>  <span class="label label-warning">0</span>
            </a>
            <ul class="dropdown-menu dropdown-messages">
                <li>
                    <div class="text-center link-block">
                        <a href="#">
                            <i class="fa fa-envelope"></i> <strong>Прочесть сообщения</strong>
                        </a>
                    </div>
                </li>
            </ul>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                <i class="fa fa-bell"></i>  <span class="label label-primary">0</span>
            </a>
            <ul class="dropdown-menu dropdown-alerts">
                
                    <div class="text-center link-block">
                        <a href="#">
                            <strong>Прочесть увдеомеления</strong>
                            <i class="fa fa-angle-right"></i>
                        </a>
                    </div>
                </li>
            </ul>
        </li>


        <li><form action="http://improf.club/exit.php" method="post">
                <button type="submit" class="btn btn-primary block full-width m-b"><i class="fa fa-power-off"> Выход</i></button>

			</form>
        </li>
    </ul>

</nav>
        <div class="wrapper wrapper-content animated fadeInRight">


            <div class="row">
                <div class="col-md-6">
                    <div class="ibox ">
                        <div class="ibox-title text-center">
                            <h2>Баланс</h2>
                        </div>
                        <div class="ibox-content col-md-12 text-center">
                            <div class="col-md-7">
                                <button type="button" class="btn btn-primary btn-sm btn-block" style="font-size: 15px" title="Пополнить свой баланс с помощью платежных систем">Пополнить баланс</button>
                                <button type="button" class="btn btn-primary btn-sm btn-block" style="font-size: 15px" title="Получить денежки на свой кошелекы">Вывести средства</button>
                            </div>
							<div class="col-md-5">
                                <p style="font-size: 20px; color: #85bb65" title="Доступный баланс"><i class="fa fa-usd"></i>&nbsp; 0.00</p>
                                <p style="font-size: 20px; color: #B22222" title="Бонусы"><i class="fa fa-database"></i>&nbsp; 0.00</p>
                            </div>
                        </div>
                    </div>
                </div>
				 <div class="col-md-6">
                    <div class="ibox">
                        <div class="ibox-title text-center">
                            <h2>Партнерская ссылка</h2>
                        </div>
                        <div class="ibox-content text-center">
						
                            <div class=" text-center">
							<?php
								include_once '/scripts/auth_check.php'; // проверяем авторизирован ли пользователь
									if($user) {
										$search_id = mysql_query("SELECT `user_id` FROM `users` WHERE `username` = '".$user['username']."'");
										$id = (mysql_num_rows($search_id) == 1) ? mysql_fetch_array($search_id) : 0;
                                        echo '<div class="panel panel-default"><div class="panel-body" style="font-size: 17px; color: #0f6b58;"><b>http://improf.club/register_p.php?p='.$id['user_id'].'</b></div></div>';
										//echo '<input type="text" class="form-control" disabled="" placeholder="http://improf.club/register_p.php?p='.$id['user_id'].'">';
                                        //echo '<span class="input-group-btn">
                                        //      <button type="button" class="btn btn-primary">Копировать</button>
                                        //      </span>';
                                    
										} else {
										// выводим информацию для гостя
										header ('Location: ../unauth_user/index.html');
										exit();
										}
							?>

    						<!--<input type="text" class="form-control" disabled="" placeholder="http://improf.club/p/123423">
							<span class="input-group-btn">
                            <button type="button" class="btn btn-primary">Копировать</button> -->
							</span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row">

                <div class="col-lg-7">

                    <div class="ibox">
                        <div class="ibox-title text-center">
                            <h2>С чего начать?</h2>
                        </div>
                        <div class="ibox-content text-center">
                            <figure>
                                <iframe width="100%" height="350px" src="https://www.youtube.com/embed/z_l9QVynumo" frameborder="0" allowfullscreen></iframe>
                            </figure>
                        </div>
                    </div>

                </div>
                <div class="col-lg-5 text-left">
                    <div style="margin-top: 100px;">
                            <a href="#">
                                <button type="button" class="btn lazur-bg m-r-sm btn-block" style="font-size: 25px; text-align:left" title="Выбрать направление бизнеса"><i
                                        class="fa fa-briefcase"></i>&nbsp;Шаг №1 Бизнес</button>
                            </a>
                            <span style='padding-left:10px;'> </span>

                            <a href="#">
                                <button type="button" class="btn red-bg m-r-sm btn-block" style="font-size: 25px; text-align:left" title="Активировать инструменты"><i
                                        class="fa fa-cogs"></i>&nbsp;Шаг №2 Инструменты</button>
                            </a>
                            <span style='padding-left:10px;'> </span>

                            <a href="#">
                                <button type="button" class="btn yellow-bg m-r-sm btn-block" style="font-size: 25px; text-align:left" title="Пройти обучение"><i
                                        class="fa fa-graduation-cap"></i>&nbsp;Шаг №3 Обучение</button>
                            </a>
                    </div>

                </div>


            </div>

        </div>

	<div class="footer">
		<div class="pull-right">
        
		</div>
    <div>
        <strong>Клуб Профессионалов</strong> Копирование материалов ЗАПРЕЩЕНО!  &copy; 2016
    </div>

    </div>
</div>



<!-- Mainly scripts -->
<script src="../../js/jquery-2.1.1.js"></script>
<script src="../../js/bootstrap.min.js"></script>
<script src="../../js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="../../js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

<!-- Custom and plugin javascript -->
<script src="../../js/inspinia.js"></script>
<script src="../../js/plugins/pace/pace.min.js"></script>

<!-- BEGIN JIVOSITE CODE {literal} -->
<script type='text/javascript'>
(function(){ var widget_id = '7VymgCnRUS';var d=document;var w=window;function l(){
var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = '//code.jivosite.com/script/widget/'+widget_id; var ss = document.getElementsByTagName('script')[0]; ss.parentNode.insertBefore(s, ss);}if(d.readyState=='complete'){l();}else{if(w.attachEvent){w.attachEvent('onload',l);}else{w.addEventListener('load',l,false);}}})();</script>
<!-- {/literal} END JIVOSITE CODE -->

</body>

</html>
