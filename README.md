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