/**
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public 
 * License as published by the Free Software Foundation, version 3.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General
 * Public License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA  02111-1307  USA
 */
package com.francisli.processing.http;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.http.HttpEntity;
import org.apache.http.StatusLine;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.stringtree.json.JSONReader;
import processing.xml.XMLElement;

/** 
 * An HttpResponse object contains both status information and the content
 * of the response to an HTTP request.
 *
 * @author Francis Li <mail@francisli.com>
 * @usage Application
 * @param response HttpResponse: any variable of type HttpResponse
 */
public class HttpResponse {
    org.apache.http.HttpResponse response;
    
    /** int: the HTTP status code of this response */
    public int statusCode;
    /** String: a short descriptive message for the current status */
    public String statusMessage;    
    /** String: the MIME type of the content, including optional character set */
    public String contentType;
    /** byte[]: the raw data content of the response */
    public byte[] content;
    /** int: the length of the content data, the same as content.length */
    public int contentLength;
    
    String contentCharSet;
        
    HttpResponse(org.apache.http.HttpResponse response) throws IOException {
        this.response = response;
        
        StatusLine status = response.getStatusLine();
        this.statusCode = status.getStatusCode();
        this.statusMessage = status.getReasonPhrase();
        
        HttpEntity entity = response.getEntity();
        if (entity.getContentType() != null) {
            contentType = entity.getContentType().getValue();
        }
        content = EntityUtils.toByteArray(entity);
        contentLength = content.length;
        contentCharSet = EntityUtils.getContentCharSet(entity);
        if (contentCharSet == null) {
            contentCharSet = HTTP.UTF_8;
        }
    }
    
    /** 
     * Converts the content into a String.
     * 
     * @return String
     */
    public String getContentAsString() {
        try {
            return new String(content, contentCharSet);
        } catch (UnsupportedEncodingException ex) {
            return new String(content);
        }
    }
    
    /** 
     * Parses the data as a JSON document and returns it as a JSONObject.
     * 
     * @return JSONObject
     */
    public JSONObject getContentAsJSONObject() {
        JSONReader json = new JSONReader();
        return new JSONObject(json.read(getContentAsString()));
    }
    
    /** 
     * Parses the data as an XML document and returns an XMLElement object.
     * 
     * @return XMLElement
     */
    public XMLElement getContentAsXMLElement() {
        return XMLElement.parse(getContentAsString());
    }
}
