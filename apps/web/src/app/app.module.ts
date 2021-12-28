import {NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';

import {AppComponent} from './app.component';
import {HeaderModule} from '@web-portfolio/ui';
import {RouterModule} from '@angular/router';
import {AppRoutingModule} from './app-routing.module';
import {StubComponent} from './stub.component';

@NgModule({
    declarations: [AppComponent, StubComponent],
    imports: [AppRoutingModule, BrowserModule, HeaderModule],
    providers: [],
    bootstrap: [AppComponent]
})
export class AppModule {
}
