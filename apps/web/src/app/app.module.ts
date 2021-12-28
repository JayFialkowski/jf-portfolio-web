import {NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';

import {AppComponent} from './app.component';
import {HeaderModule} from '@web-portfolio/ui';
import {RouterModule} from '@angular/router';

@NgModule({
    declarations: [AppComponent],
    imports: [BrowserModule, HeaderModule, RouterModule.forRoot([])],
    providers: [],
    bootstrap: [AppComponent]
})
export class AppModule {
}
