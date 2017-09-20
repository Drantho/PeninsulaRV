using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PeninsulaRV.Startup))]
namespace PeninsulaRV
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
