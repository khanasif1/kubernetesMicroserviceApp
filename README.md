# Kubernetes Microservice Application
Microservice architecture based kubernetes application
<!-- wp:heading -->
<h2>Application Overview</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>For this blog the application architecture I have used involves stateful and stateless applications. </p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":4784,"width":753,"height":505,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://khanasif1.files.wordpress.com/2020/11/apparch-1.png?w=820" alt="" class="wp-image-4784" width="753" height="505"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>The solution comprised of below components:</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>Polyglot database design, SQL container instance on Linux are used<ul><li><span class="has-inline-color has-luminous-vivid-orange-color"><strong>Staff DB (SQL Server container) :</strong> </span>This store all staff records</li><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">Product DB <strong>(SQL Server container)</strong>:</span></strong> This will hold all product records</li></ul></li><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">Staff API (.NET Core): </span></strong>This API layer helps in accessing staff records</li><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">Product API <strong>(.NET Core)</strong>:</span></strong> This API helps in accessing product records</li><li><span class="has-inline-color has-luminous-vivid-orange-color"><b>Sales API (</b></span><strong><span class="has-inline-color has-luminous-vivid-orange-color">NodeJS):</span></strong> This API consumes Staff and Product API it then massages the data to build enriched Sales entity by mapping products with staff.</li><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">UI Frontend (ASPNET Core):</span></strong> UI has Home screen from where you can navigate to Staff , Product or Sales records.</li></ul>
<!-- /wp:list -->
<!-- wp:heading -->
<h2>Database Component</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Staff and Product DB are both deployed as a container. The container uses native Microsoft SQL Server container image. Database is a statefull application hence it also needs a persistent storage. Since container are build on the ideology of kill and recreate if error. Hence if the database containers do not use external persistent storage, the data will be lost once the container is killed.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>There are wide variety of options to choose from, for persistent storage. In this demo I am using Azure storage disk for persistence.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":4792,"width":282,"height":304,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://khanasif1.files.wordpress.com/2020/11/db.png?w=274" alt="" class="wp-image-4792" width="282" height="304"/></figure>
<!-- /wp:image -->

<!-- wp:heading -->
<h2>API Components</h2>
<!-- /wp:heading -->

<!-- wp:heading {"level":3} -->
<h3>Staff &amp; Product API <a href="https://github.com/khanasif1/kubernetesMicroserviceApp" target="_blank" rel="noreferrer noopener">(Github Link)</a></h3>
<!-- /wp:heading -->

<!-- wp:image {"width":305,"height":121,"sizeSlug":"large"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://khanasif1.files.wordpress.com/2020/11/aspnetcoreapi.png?w=970" alt="" width="305" height="121"/></figure>
<!-- /wp:image -->

<!-- wp:image {"align":"center","width":120,"height":288,"sizeSlug":"large"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><img src="https://khanasif1.files.wordpress.com/2020/12/api.png?w=178" alt="" width="120" height="288"/></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Staff &amp; Product API is build using ASPNET Core, with openAPI standards. The solution I pretty simple, it has below API’s :</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li><span class="has-inline-color has-luminous-vivid-orange-color"><strong>GetMetadata : </strong></span>This is just for internal testing, I would not keep this open if deployed in production. This was just for checking the connection details with DB container. I am pulling the connection details from environment variable, which set through the container deployment Yaml.</li><li><span class="has-inline-color has-luminous-vivid-orange-color"><strong>Get “Get All Staff/Products”: </strong></span>Staff &amp; Product API method does nothing much fancy, below are the activity performed by this API:<ul><li>It builds the database schema if not exists</li><li>It seeds the database with records</li><li>It connects to database and pulls all records.</li><li>It then return the records as a custom entity generic list.</li></ul></li></ul>
<!-- /wp:list -->
<!-- wp:heading {"level":4} -->
<h4>Sales API<a href="https://github.com/khanasif1/kubernetesMicroserviceApp/tree/master/k8.kubernetesWorld.Service.Sales" target="_blank" rel="noreferrer noopener"> (Github Link)</a></h4>
<!-- /wp:heading -->

<!-- wp:columns -->
<div class="wp-block-columns"><!-- wp:column {"width":"100%"} -->
<div class="wp-block-column" style="flex-basis:100%"><!-- wp:columns -->
<div class="wp-block-columns"><!-- wp:column {"width":"100%"} -->
<div class="wp-block-column" style="flex-basis:100%"><!-- wp:image {"align":"center","id":4800,"width":283,"height":131,"sizeSlug":"large","linkDestination":"none","className":"is-style-default"} -->
<div class="wp-block-image is-style-default"><figure class="aligncenter size-large is-resized"><img src="https://khanasif1.files.wordpress.com/2020/11/nodejs.jpg?w=778" alt="" class="wp-image-4800" width="283" height="131"/></figure></div>
<!-- /wp:image --></div>
<!-- /wp:column --></div>
<!-- /wp:columns --></div>
<!-- /wp:column --></div>
<!-- /wp:columns -->

<!-- wp:paragraph -->
<p>Sales API in contrast to Staff and Product API does not interact with any database. Also Sales API is build  using <strong>NodeJS with express</strong>. It relies on Staff and Product API for data feed. Below are activity performed by Sales API</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><strong><span class="has-inline-color has-luminous-vivid-orange-color">Get Sales</span></strong>:</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>Connect with Staff and Product API to source data</li><li>Model Staff and Product data to build Sales entity, by mapping Staffs to Products</li><li>Return Sales entity as a response to API call</li></ul>
<!-- /wp:list -->
<!-- wp:heading {"level":4} -->
<h4>User Interface Frontend <a href="https://github.com/khanasif1/kubernetesMicroserviceApp/tree/master/k8.kubernetesWorld.Web" target="_blank" rel="noreferrer noopener">(Github Link)</a></h4>
<!-- /wp:heading -->

<!-- wp:columns -->
<div class="wp-block-columns"><!-- wp:column {"width":"100%"} -->
<div class="wp-block-column" style="flex-basis:100%"><!-- wp:image {"align":"left","id":4810,"width":290,"height":192,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="alignleft size-large is-resized"><a href="https://khanasif1.files.wordpress.com/2020/11/asp.net-core-mvc.png"><img src="https://khanasif1.files.wordpress.com/2020/11/asp.net-core-mvc.png?w=1000" alt="" class="wp-image-4810" width="290" height="192"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:image {"align":"left","id":4818,"width":118,"height":176,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="alignleft size-large is-resized"><a href="https://khanasif1.files.wordpress.com/2020/12/ui.png"><img src="https://khanasif1.files.wordpress.com/2020/12/ui.png?w=142" alt="" class="wp-image-4818" width="118" height="176"/></a></figure></div>
<!-- /wp:image --></div>
<!-- /wp:column --></div>
<!-- /wp:columns -->

<!-- wp:paragraph -->
<p>UI project is a vanilla ASPNET Core MVC project. It basically has four screens as below:</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">Home Screen</span>:</strong> It has menu items using which you can navigate to relevant screens</li><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">Product Screen:</span></strong> View gets the data from controller which call the Product API for data feed</li><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">Staff Screen:</span></strong> View gets the data from controller which call the Staff API for data feed</li><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">Sales Screen:</span></strong> View gets the data from controller which call the Sales API for data feed</li></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p>In the Part-2 of this blog series <em><strong><span style="color:#f50505;" class="has-inline-color"><em><strong>"</strong></em>coming soon<em><strong><em><strong>"</strong></em></strong></em></span></strong></em> I will walk through  Yaml files which we will be using to deploy this solution on Azure Kubernetes Services.</p>
<!-- /wp:paragraph -->