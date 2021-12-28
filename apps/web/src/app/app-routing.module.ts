import {RouterModule, Routes} from '@angular/router';
import {NgModule} from '@angular/core';
import {StubComponent} from './stub.component';

const routes: Routes = [
    {
        path: '',
        pathMatch: 'full',
        component: StubComponent
    },
    {
        path: 'resume',
        pathMatch: 'full',
        loadChildren: () => import('./modules/resume/resume.module').then(m => m.ResumeModule)
    },
    {
        path: 'contact',
        pathMatch: 'full',
        component: StubComponent
    }
];

@NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
})
export class AppRoutingModule {
}
