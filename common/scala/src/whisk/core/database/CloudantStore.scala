/*
 * Copyright 2015-2016 IBM Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package whisk.core.database

import com.cloudant.client.api.{ View => CloudantView }

object CloudantStore {
  def make[R,D <: DocumentSerializer](protocol: String, host: String, port: Int, dbUsername: String, dbPassword: String, dbName: String) = {
      new CouchDbLikeStore[CloudantView,R,D](CloudantProvider, "https", host, port, dbUsername, dbPassword, dbName)
  }
}
