export function getBaseUrl() {
  const base_element = document.getElementsByTagName("base")[0];
  let url = base_element
    ? base_element.getAttribute("href")
    : "http://localhost:8080";
  // Ensure no trailing slash
  return url.endsWith("/") ? url.slice(0, -1) : url;
}
