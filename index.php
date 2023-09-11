<?php
header("Content-Type:application/json");


//require_once('vendor/autoload.php'); 

  

	

    //$con = new mysqli();



	if(isset($_GET["p"]))
	{ 
        //$con = getCon();

		if($_GET["p"]=="MasterCategory")

		{

			getMasterCategories();

		}

		else if($_GET["p"]=="SubCategories")
		{

			getSubCategory();

		}

		else if($_GET["p"]=="CategoryProducts")
		{

			getCategoryProducts();

		}

		else if($_GET["p"]=="ProductDetails")
		{

			getProductDetails();

		}
		else if($_GET["p"]=="Products")
		{
			getProducts();
		}
		else if($_GET["p"]=="ProductsV2")
		{
			getProductsV2();
		}
		else if($_GET["p"]=="Items")
		{
			getItems();
		}
		else if($_GET["p"]=="Login")
		{
			getCustomerDetailsAfterLogin();
		}
		else if($_GET["p"]=="Register")
		{
			registerCustomert();
		}

	}

	else

	{

		echo"Not Found";

	}
	



	function registerCustomert()
	{
		$con = getCon();

		$name = $_GET['name'];
		$mobile = $_GET['mobile'];
		$email = $_GET['email'];
		$password = $_GET['password'];

        $error = "";
		$msg = "";
		$cust_id = "";
		//$CatImagePath = getCatImagePath();
		
        $array_out = array();

		$check_mobile = "select * from customers WHERE customer_contact='$mobile'";

        $run_user = mysqli_query($con,$check_mobile);

        if ($row = mysqli_fetch_object($run_user)) 
        {
				// Mobile Exists 


				$error .= "Mobile Number";

		}



		$check_email = "select * from customers WHERE customer_email='$email'";

		$run_user = mysqli_query($con,$check_email);


		if ($row = mysqli_fetch_object($run_user)) 
		{		

			if($error != "")
			{
				$error .= " AND";
			}

			$error .= " Email ID";

		}
		else
		{

			$insert_user = "INSERT INTO `customers`(`customer_name`, `customer_email`, `customer_pass`, `customer_contact`, `customer_image`, `customer_country`, `customer_city`, `customer_address`, `customer_ip`, `customer_confirm_code`) 
								VALUES ('$name','$email','$password','$mobile','','','','','','')";

			$run_user = mysqli_query($con,$insert_user);

//echo $insert_user;

			if ($run_user) 
			{
				$cust_id = mysqli_insert_id($con);
				//$imageURL = getImageUrl($row->cat_image,$CatImagePath);

				
				$msg = "Success";

				

				//array_push($array_out, );
				
			}
		}

		if($error != "")
		{
			$error .= " Already Exists.";
		}



        $array_out[] = 
						array(
							"id" => $cust_id,
							"msg" => $msg,
							"error" => $error
							
						);
        

        
    		//$output=array( "code" => "200", "msg" => $array_out);

            print_r(json_encode($array_out, true));
    		

        //print_r($row_orders);


	}

	
	function getCustomerDetailsAfterLogin()
	{
		$con = getCon();

		$mobile = $_GET['mobile'];
		$password = $_GET['password'];

        
        //$CatImagePath = getCatImagePath();
        
        $get_user = "select * from customers WHERE customer_contact='$mobile' AND customer_pass='$password'";

        $run_user = mysqli_query($con,$get_user);

        $array_out = array();


        while ($row = mysqli_fetch_object($run_user)) 
        {
			
			//$imageURL = getImageUrl($row->cat_image,$CatImagePath);

            


            $array_out[] = 
            array(
                "id" => $row->customer_id,
                "name" => $row->customer_name,
				"mobile" => $row->customer_contact,
				"email" => $row->customer_email
            );

            //array_push($array_out, );
            
        }

        
    		//$output=array( "code" => "200", "msg" => $array_out);

            print_r(json_encode($array_out, true));
    		

        //print_r($row_orders);


	}
    

	function getProductDetails()
	{
		
        $con = getCon();
		
		$CatImagePath = getCatImagePath();
        $ProductImagePath = getProductImagePath();
		
		
		$pro_id = $_GET['proid'];

		$array_pro = array();
		$get_product = "select * from products WHERE product_id='$pro_id'";
		$run_product = mysqli_query($con,$get_product);
		while($product = mysqli_fetch_object($run_product))
		{

			// Get Manufacturer

			$manufacturer_id = $product->manufacturer_id;
			$get_man = "select * from manufacturers WHERE manufacturer_id='$manufacturer_id'";
			$run_man = mysqli_query($con,$get_man);
			$brand = mysqli_fetch_object($run_man);


			// Get Items
			$get_items = "select * from item WHERE product_id='$pro_id'";
			$run_items = mysqli_query($con,$get_items);
			
			$array_items = array();

			while($items = mysqli_fetch_object($run_items))
			{
				$array_items[] = array(
					"id" => $items->id,
					"name" => $items->item_name,
					"unit" => $items->item_unit,
					"price" => $items->price,
					"offer_price" => $items->offer_price,
					"op_stock" => $items->op_stock,
					"store_id" => $items->store_id,
				);
			}

			

			$productImageURL = getImageUrl($product->product_img1, $ProductImagePath);

			$array_pro[] = array(
				"product_id" => $pro_id,
				"name" => $product->product_title,
				"manufacturer" => $brand->manufacturer_title,
				"unit" => $product->product_unit,
				"store_id" => $product->store_id,
				"image" => $productImageURL,
				"items" => $array_items,

			);
		}

		print_r(json_encode($array_pro, true));


	}



    function getCategoryProducts()
    {

        $con = getCon();
		
		$CatImagePath = getCatImagePath();
        $ProductImagePath = getProductImagePath();
		
		
		$catid = $_GET['catid'];

        
	    //$input = @file_get_contents("php://input");

	    //$event_json = json_decode($input, true);

        //$catid=htmlspecialchars(strip_tags($event_json['catid'] , ENT_QUOTES));
        
        $get_orders = "select * from categories WHERE parent_id='$catid'";

        $run_orders = mysqli_query($con,$get_orders);

        $array_out = array();

        while ($row = mysqli_fetch_object($run_orders)) 
        {

			// Get Products 

			$cat_id = $row->cat_id;
			$get_products = "select * from product_categories WHERE cat_id='$cat_id'";

        	$run_products = mysqli_query($con,$get_products);

			$array_pro = array();

			while($pros = mysqli_fetch_object($run_products))
			{
				$pro_id = $pros->product_id;
				$get_product = "select * from products WHERE product_id='$pro_id'";
				$run_product = mysqli_query($con,$get_product);
				$product = mysqli_fetch_object($run_product);

// Get Manufacturer

				$manufacturer_id = $product->manufacturer_id;
				$get_man = "select * from manufacturers WHERE manufacturer_id='$manufacturer_id'";
				$run_man = mysqli_query($con,$get_man);
				$brand = mysqli_fetch_object($run_man);


				// Get Items

			
				$get_items = "select * from item WHERE product_id='$pro_id'";
				$run_items = mysqli_query($con,$get_items);
				
				$array_items = array();

				while($items = mysqli_fetch_object($run_items))
				{
					$array_items[] = array(
						"id" => $items->id,
						"name" => $items->item_name,
						"unit" => $items->item_unit,
						"price" => $items->price,
						"offer_price" => $items->offer_price,
						"op_stock" => $items->op_stock,
						"store_id" => $items->store_id,
					);
				}

				



				$array_pro[] = array(
					"product_id" => $pro_id,
					"name" => $product->product_title,
					"manufacturer" => $brand->manufacturer_title,
					"unit" => $product->product_unit,
					"store_id" => $product->store_id,
					"image" => $ProductImagePath.$product->product_img1,
					"items" => $array_items,

				);

			}


            $array_out[] = 
            array(
				"id" => $row->cat_id,
				"name" => $row->cat_title,
				"image" => $CatImagePath.$row->cat_image,
				"products" => $array_pro
                
            );

        }

//echo $catid;

        print_r(json_encode($array_out, true));

	}


	function getItems()
    {

        $con = getCon();
		
		$CatImagePath = getCatImagePath();
        $ProductImagePath = getProductImagePath();
		
		
		$proid = $_GET['proid'];

        
			

		// Get Items

			
		$get_items = "select * from item WHERE product_id='$proid'";
		$run_items = mysqli_query($con,$get_items);
		
		$array_items = array();

		while($items = mysqli_fetch_object($run_items))
		{
			$array_items[] = array(
				"id" => $items->id,
				"name" => $items->item_name,
				"unit" => $items->item_unit,
				"price" => $items->price,
				"offer_price" => $items->offer_price,
				"op_stock" => $items->op_stock,
				"store_id" => $items->store_id,
			);
		}

				



			

			


           

        
//echo $catid;

        print_r(json_encode($array_items, true));

	}



	function getProducts()
    {

        $con = getCon();
		
		$CatImagePath = getCatImagePath();
        $ProductImagePath = getProductImagePath();
		
		
		$catid = $_GET['catid'];

        
	    //$input = @file_get_contents("php://input");

	    //$event_json = json_decode($input, true);

        //$catid=htmlspecialchars(strip_tags($event_json['catid'] , ENT_QUOTES));
        
        

			// Get Products 

			
			$get_products = "select * from product_categories WHERE cat_id='$catid'";

        	$run_products = mysqli_query($con,$get_products);

			$array_pro = array();

			while($pros = mysqli_fetch_object($run_products))
			{
				$pro_id = $pros->product_id;
				$get_product = "select * from products WHERE product_id='$pro_id'";
				$run_product = mysqli_query($con,$get_product);
				$product = mysqli_fetch_object($run_product);

// Get Manufacturer

				$manufacturer_id = $product->manufacturer_id;
				$get_man = "select * from manufacturers WHERE manufacturer_id='$manufacturer_id'";
				$run_man = mysqli_query($con,$get_man);
				$brand = mysqli_fetch_object($run_man);


				// Get Items

			
				$get_items = "select * from item WHERE product_id='$pro_id'";
				$run_items = mysqli_query($con,$get_items);
				
				$array_items = array();

				while($items = mysqli_fetch_object($run_items))
				{
					$array_items[] = array(
						"id" => $items->id,
						"name" => $items->item_name,
						"unit" => $items->item_unit,
						"price" => $items->price,
						"offer_price" => $items->offer_price,
						"op_stock" => $items->op_stock,
						"store_id" => $items->store_id,
					);
				}

				



				$array_pro[] = array(
					"product_id" => $pro_id,
					"name" => $product->product_title,
					"manufacturer" => $brand->manufacturer_title,
					"unit" => $product->product_unit,
					"store_id" => $product->store_id,
					"image" => $ProductImagePath.$product->product_img1,
					"items" => $array_items,

				);

			}


           

        
//echo $catid;

        print_r(json_encode($array_pro, true));

	}


	function getProductsV2()
    {

        $con = getCon();
		
		$CatImagePath = getCatImagePath();
        $ProductImagePath = getProductImagePath();
		
		
		$catid = $_GET['catid'];

        
	    //$input = @file_get_contents("php://input");

	    //$event_json = json_decode($input, true);

        //$catid=htmlspecialchars(strip_tags($event_json['catid'] , ENT_QUOTES));
        
        

			// Get Products 

			
			$get_products = "select * from product_categories WHERE cat_id='$catid'";

        	$run_products = mysqli_query($con,$get_products);

			$array_pro = array();
			$array_items = array();

			while($pros = mysqli_fetch_object($run_products))
			{
				$pro_id = $pros->product_id;
				$get_product = "select * from products WHERE product_id='$pro_id'";
				$run_product = mysqli_query($con,$get_product);
				$product = mysqli_fetch_object($run_product);

// Get Manufacturer

				$manufacturer_id = $product->manufacturer_id;
				$get_man = "select * from manufacturers WHERE manufacturer_id='$manufacturer_id'";
				$run_man = mysqli_query($con,$get_man);
				$brand = mysqli_fetch_object($run_man);


				// Get Items

			
				$get_items = "select * from item WHERE product_id='$pro_id'";
				$run_items = mysqli_query($con,$get_items);
				

				while($items = mysqli_fetch_object($run_items))
				{
					$array_items[] = array(
						"product_id" => $pro_id,
						"item_id" => $items->id,
						"product_name" => $product->product_title,
						"item_name" => $items->item_name,
						"manufacturer" => $brand->manufacturer_title,
						"product_type" => $product->product_type,
						"unit" => $items->item_unit,
						"pro_unit" => $product->product_unit,
						"price" => $items->price,
						"offer_price" => $items->offer_price,
						"op_stock" => $items->op_stock,
						"image" => $ProductImagePath.$product->product_img1,
						"store_id" => $items->store_id,
					);
				}

				



				$array_pro[] = array(
					"product_id" => $pro_id,
					"name" => $product->product_title,
					"manufacturer" => $brand->manufacturer_title,
					"unit" => $product->product_unit,
					"store_id" => $product->store_id,
					"image" => $ProductImagePath.$product->product_img1,
					"items" => $array_items,

				);

			}


           

        
//echo $catid;

        print_r(json_encode($array_items, true));

	}

	
	function getSubCategory()
	{
		$con = getCon();

		$catid = $_GET['catid'];

        
        $CatImagePath = getCatImagePath();
        
        $get_orders = "select * from categories WHERE parent_id='$catid'";

        $run_orders = mysqli_query($con,$get_orders);

        $array_out = array();


        while ($row = mysqli_fetch_object($run_orders)) 
        {
			
			$imageURL = getImageUrl($row->cat_image,$CatImagePath);

            


            $array_out[] = 
            array(
                "id" => $row->cat_id,
                "name" => $row->cat_title,
                "image" => $imageURL
            );

            //array_push($array_out, );
            
        }

        
    		//$output=array( "code" => "200", "msg" => $array_out);

            print_r(json_encode($array_out, true));
    		

        //print_r($row_orders);


	}


    function getMasterCategories()
    {

        $con = getCon();
        
        $CatImagePath = getCatImagePath();
        
        $get_orders = "select * from categories WHERE parent_id='1'";

        $run_orders = mysqli_query($con,$get_orders);

        $array_out = array();


        while ($row = mysqli_fetch_object($run_orders)) 
        {

			$imageURL = getImageUrl($row->cat_image,$CatImagePath);

            $array_out[] = 
            array(
                "id" => $row->cat_id,
                "name" => $row->cat_title,
                "image" => $imageURL
            );

            //array_push($array_out, );
            
        }

        
    		//$output=array( "code" => "200", "msg" => $array_out);

            print_r(json_encode($array_out, true));
    		

        //print_r($row_orders);

	}
	



	function getCon()
    {
        require_once("../admin/includes/db.php");


        return  $con;
	}
	
	function getCatImagePath()
	{
		$CatImagePath = "admin/categories/";
		return $CatImagePath;
	}

	function getProductImagePath()
	{
		$ProductImagePath = "admin/product_images/";
		return $ProductImagePath;
	}

	function getImageUrl($image,$path)
	{
		$img = "";
		if($image == "0")
		{
			$img = "api/no.jpg";

		}
		else if($image != "")
		{
			$img = $path.$image;
		}

		return $img;
	}
	



	

	function sendPushNotificationToMobileDevice($data)

	{

        require_once("config_sajid.php");

        $key = firebase_key;

      

        $curl = curl_init();



        curl_setopt_array($curl, array(

            CURLOPT_URL => "https://fcm.googleapis.com/fcm/send",

            CURLOPT_RETURNTRANSFER => true,

            CURLOPT_ENCODING => "",

            CURLOPT_MAXREDIRS => 10,

            CURLOPT_TIMEOUT => 30,

            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,

            CURLOPT_CUSTOMREQUEST => "POST",

            CURLOPT_POSTFIELDS => $data,

            CURLOPT_HTTPHEADER => array(

                "authorization: key=".$key."",

                "cache-control: no-cache",

                "content-type: application/json",

                "postman-token: 85f96364-bf24-d01e-3805-bccf838ef837"

            ),

        ));



        $response = curl_exec($curl);

        $err = curl_error($curl);



        curl_close($curl);



        if($err) 

        {

           // print_r($err);

        } 

        else 

        {

            //print_r($response);

        }

    }

	

	/*********************************************/

	/******         Code By Sajid          *******/

	/*********************************************/

	

	function rand_num($digits) 

	{

		$min = pow(10, $digits - 1);

		$max = pow(10, $digits) - 1;

		return mt_rand($min, $max);

	}

	

	function sendOTP()

	{

		require_once("config_sajid.php");

	    $input = @file_get_contents("php://input");

	    $event_json = json_decode($input, true);

				

		if($event_json['email_id']!="" && $event_json['first_name']!="" && $event_json['last_name']!="" )

		{  

			$email_id = htmlspecialchars_decode(stripslashes($event_json['email_id']));

			$first_name = htmlspecialchars(strip_tags($event_json['first_name'], ENT_QUOTES));

			$last_name = htmlspecialchars(strip_tags($event_json['last_name'], ENT_QUOTES));

			$signup_type = htmlspecialchars_decode(stripslashes($event_json['signup_type']));

			//$profile_pic=htmlspecialchars_decode(stripslashes($event_json['profile_pic']));

								    

			$otp = rand_num(6);					

			// $to_email = 'sajid@gpslab.in';

			$fr_email = 'noreply@gpslab.in';		 

			$subject = 'OTP Generated - OTP:'.$otp;

			$message = 'Hi '.$first_name.' '.$last_name.', your OTP is '.$otp;

			$message = wordwrap($message, 70);

			$headers = 'From: '.$fr_email;				 

			$resp = mail($email_id, $subject, $message, $headers);

						

			$sql = "INSERT INTO login_otp (email_id, otp, isused) VALUES ('$email_id', '$otp', 'N')";

			$rs = mysqli_query($conn, $sql);

			

			if($rs)

			{

				 $array_out = array();

				 $array_out[] = 

					//array("code" => "200");

					array(						

						"action" => "SendOTP",	

						"email_id" => $email_id,

						"first_name" => $first_name,

						"last_name" => $last_name,

						"signup_type" => $signup_type						

					);

				

				 $output=array( "code" => "200", "msg" => $array_out);

				 print_r(json_encode($output, true));

			}

			else

			{

				//echo mysqli_error();

				$array_out = array();					

				$array_out[] = 

					array(

					"response" =>"problem in signup");

				

				$output=array( "code" => "201", "msg" => $array_out);

				print_r(json_encode($output, true));

			}

		}

		else

		{

			$array_out = array();					

			$array_out[] = 

				array(

				"response" =>"JSON Param are missing");

			

			$output=array( "code" => "201", "msg" => $array_out);

			print_r(json_encode($output, true));

		}

	}

	






	function search()

	{

	    

	    require_once("config_sajid.php");

	    $input = @file_get_contents("php://input");

	    $event_json = json_decode($input,true);

		//print_r($event_json);

	

		$type=htmlspecialchars(strip_tags($event_json['type'] , ENT_QUOTES));

		$keyword=htmlspecialchars(strip_tags($event_json['keyword'] , ENT_QUOTES));

		

		if($type=="video")

	    {

	        $query = mysqli_query($conn,"select * from videos where description like '%".$keyword."%' order by rand()");

    	    $array_out = array();

    		while($row=mysqli_fetch_array($query))

    		{

    		    

    		    $query1=mysqli_query($conn,"select * from users where fb_id='".$row['fb_id']."' ");

    	        $rd=mysqli_fetch_object($query1);

    	       

    	        $query112=mysqli_query($conn,"select * from sound where id='".$row['sound_id']."' ");

    	        $rd12=mysqli_fetch_object($query112);

    	        

    	        $countLikes = mysqli_query($conn,"SELECT count(*) as count from video_like_dislike where video_id='".$row['id']."' ");

                $countLikes_count=mysqli_fetch_assoc($countLikes);

    	        

    	        $countcomment = mysqli_query($conn,"SELECT count(*) as count from video_comment where video_id='".$row['id']."' ");

                $countcomment_count=mysqli_fetch_assoc($countcomment);

                

                

                $liked = mysqli_query($conn,"SELECT count(*) as count from video_like_dislike where video_id='".$row['id']."' and fb_id='".$fb_id."' ");

                $liked_count=mysqli_fetch_assoc($liked);

    	        

        	   	$array_out[] = 

        			array(

        			"id" => $row['id'],

        			"fb_id" => $row['fb_id'],

        			"user_info" =>array

            					(

            					    "first_name" => $rd->first_name,

                        			"last_name" => $rd->last_name,

                        			"profile_pic" => $rd->profile_pic,

                        			"username" => $rd->username,

            					),

            		"count" =>array

            					(

            					    "like_count" => $countLikes_count['count'],

                        			"video_comment_count" => $countcomment_count['count'],

                        			"view" => $row['view'],

            					),

            		"liked"=> $liked_count['count'],			

            	    

					//"video" => checkVideoUrl($row['video']),

        			//"thum" => checkVideoUrl($row['thum']),

        			//"gif" => checkVideoUrl($row['gif']),

					

					"video" => $row['video'],

        			"thum" => $row['thum'],

        			"gif" => $row['gif'],

					

        			"description" => $row['description'],

        			"sound" =>array

            					(

            					    "id" => $rd12->id,

            					    "audio_path" => 

                            			array(

                                			"mp3" => $API_path."/upload/audio/".$rd12->id.".mp3",

                    			            "acc" => $API_path."/upload/audio/".$rd12->id.".aac"

                                		),

                        			"sound_name" => $rd12->sound_name,

                        			"description" => $rd12->description,

                        			"thum" => $rd12->thum,

                        			"section" => $rd12->section,

                        			"created" => $rd12->created,

            					),

        			"created" => $row['created']

        		);

    			

    		}

    		$output=array( "code" => "200", "msg" => $array_out);

    		print_r(json_encode($output, true));

	    }

	    else

	    if($type=="users")

	    {

	        $query=mysqli_query($conn,"select * from users where first_name like '%".$keyword."%' or last_name like '%".$keyword."%' or username like '%".$keyword."%'   ");

    	    $array_out = array();

    		while($row=mysqli_fetch_array($query))

    		{

    		     $query1=mysqli_query($conn,"select * from videos where fb_id='".$row['fb_id']."' ");

	             $videoCount=mysqli_num_rows($query1);

            

    		   	 $array_out[] = 

    				array(

    					"fb_id" => $row['fb_id'],

    					"username" => utf8_encode($row['username']),

    					"first_name" => utf8_encode($row['first_name']),

    					"last_name" => utf8_encode($row['last_name']),

    					"gender" => $row['gender'],

    					"profile_pic" => $row['profile_pic'],

    					"block" => $row['block'],

    					"version" => $row['version'],

    					"device" => $row['device'],

    					"signup_type" => $row['signup_type'],

    					"created" => $row['created'],

    					"videos" => $videoCount

    				);

    			

    		}

    		$output=array( "code" => "200", "msg" => $array_out);

    		print_r(json_encode($output, true));

	    }

		else

        if($type=="sound")

		{

		   $query1=mysqli_query($conn,"select * from sound where sound_name like '%".$keyword."%' or description like '%".$keyword."%' ");

	       $array_out1 = array();

		   while($row1=mysqli_fetch_array($query1))

		   {

		        $qrry="select * from fav_sound WHERE fb_id='".$fb_id."' and sound_id ='".$row1['id']."' ";

    			$log_in_rs=mysqli_query($conn,$qrry);

    			$CountFav = mysqli_num_rows($log_in_rs); 

    		    if($CountFav=="")

    		    {

    		        $CountFav="0";

    		    }

    		    

		        $array_out1[] = 

        			array(

            			"id" => $row1['id'],

            			

            			"audio_path" => 

                    			array(

                        			"mp3" => $API_path."/upload/audio/".$row1['id'].".mp3",

            			            "acc" => $API_path."/upload/audio/".$row1['id'].".aac"

                        		),

            			"sound_name" => $row1['sound_name'],

            			"description" => $row1['description'],

            			"section" => $row1['section'],

            			"thum" => $row1['thum'],

            			"created" => $row1['created'],

            			"fav" => $CountFav

            		);

		    }			

    		$output=array( "code" => "200", "msg" => $array_out1);

    		print_r(json_encode($output, true));

		}

		

	}

?>



