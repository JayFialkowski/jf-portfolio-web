import {NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';

import {AppComponent} from './app.component';
import {HeaderModule} from '@web-portfolio/ui';
import {RouterModule} from '@angular/router';
import {AppRoutingModule} from './app-routing.module';

@NgModule({
    declarations: [AppComponent],
    imports: [AppRoutingModule, BrowserModule, HeaderModule],
    providers: [],
    bootstrap: [AppComponent]
})
export class AppModule {
}
